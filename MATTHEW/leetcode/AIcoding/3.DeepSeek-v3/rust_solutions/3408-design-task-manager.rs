use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct TaskManager {
    tasks: HashMap<i32, i32>,
    available_ids: BinaryHeap<Reverse<i32>>,
    max_id: i32,
}

impl TaskManager {
    fn new() -> Self {
        TaskManager {
            tasks: HashMap::new(),
            available_ids: BinaryHeap::new(),
            max_id: 0,
        }
    }

    fn add_task(&mut self, duration: i32) -> i32 {
        let id = if let Some(Reverse(id)) = self.available_ids.pop() {
            id
        } else {
            self.max_id += 1;
            self.max_id
        };
        self.tasks.insert(id, duration);
        id
    }

    fn check_task(&self, id: i32) -> bool {
        self.tasks.contains_key(&id)
    }

    fn cancel_task(&mut self, id: i32) -> bool {
        if self.tasks.remove(&id).is_some() {
            self.available_ids.push(Reverse(id));
            true
        } else {
            false
        }
    }

    fn process_tasks(&mut self) -> Vec<i32> {
        let mut res = Vec::new();
        let mut to_remove = Vec::new();

        for (&id, duration) in self.tasks.iter_mut() {
            *duration -= 1;
            if *duration == 0 {
                to_remove.push(id);
            }
        }

        for id in to_remove {
            self.tasks.remove(&id);
            self.available_ids.push(Reverse(id));
            res.push(id);
        }

        res
    }
}