use std::collections::{HashMap, HashSet};
use std::time::{Duration, Instant};

struct TaskManager {
    tasks: HashMap<i32, (u32, Instant)>,
    completed: HashSet<i32>,
}

impl TaskManager {
    fn new() -> Self {
        TaskManager {
            tasks: HashMap::new(),
            completed: HashSet::new(),
        }
    }

    fn add_task(&mut self, task_id: i32, duration: u32) {
        self.tasks.insert(task_id, (duration, Instant::now()));
    }

    fn complete_task(&mut self, task_id: i32) {
        if let Some((duration, _)) = self.tasks.remove(&task_id) {
            self.completed.insert(task_id);
        }
    }

    fn get_remaining_time(&self, task_id: i32) -> Option<u32> {
        if let Some(&(duration, start_time)) = self.tasks.get(&task_id) {
            let elapsed = Instant::now().duration_since(start_time);
            let remaining = duration.saturating_sub(elapsed.as_secs() as u32);
            return Some(remaining);
        }
        None
    }

    fn get_completed_tasks(&self) -> Vec<i32> {
        self.completed.iter().cloned().collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_task_manager() {
        let mut tm = TaskManager::new();
        tm.add_task(1, 10);
        tm.add_task(2, 20);
        assert_eq!(tm.get_remaining_time(1).is_some(), true);
        tm.complete_task(1);
        assert_eq!(tm.get_remaining_time(1).is_none(), true);
        assert_eq!(tm.get_completed_tasks(), vec![1]);
    }
}