use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Eq)]
struct Task {
    id: i32,
    description: String,
    due_date: i64,
    completed: bool,
}

struct TaskManager {
    tasks: HashMap<i32, Task>,
}

impl TaskManager {
    fn new() -> Self {
        TaskManager {
            tasks: HashMap::new(),
        }
    }

    fn add_task(&mut self, id: i32, description: String, due_date: i64) -> bool {
        if self.tasks.contains_key(&id) {
            false
        } else {
            let task = Task {
                id,
                description,
                due_date,
                completed: false,
            };
            self.tasks.insert(id, task);
            true
        }
    }

    fn mark_task_completed(&mut self, id: i32) -> bool {
        if let Some(task) = self.tasks.get_mut(&id) {
            if !task.completed {
                task.completed = true;
                true
            } else {
                false
            }
        } else {
            false
        }
    }

    fn get_pending_tasks(&self, current_time: i64) -> Vec<Task> {
        let mut pending_tasks: Vec<Task> = self.tasks.values()
            .filter(|task| !task.completed && task.due_date <= current_time)
            .cloned()
            .collect();

        pending_tasks.sort_by_key(|task| task.due_date);
        pending_tasks
    }

    fn get_all_pending_tasks(&self) -> Vec<Task> {
        let mut all_pending_tasks: Vec<Task> = self.tasks.values()
            .filter(|task| !task.completed)
            .cloned()
            .collect();

        all_pending_tasks.sort_by_key(|task| task.due_date);
        all_pending_tasks
    }

    fn get_completed_tasks(&self) -> Vec<Task> {
        let mut completed_tasks: Vec<Task> = self.tasks.values()
            .filter(|task| task.completed)
            .cloned()
            .collect();

        completed_tasks.sort_by_key(|task| task.due_date);
        completed_tasks
    }
}