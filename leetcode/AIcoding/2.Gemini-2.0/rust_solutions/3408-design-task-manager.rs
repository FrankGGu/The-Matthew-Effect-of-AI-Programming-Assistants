use std::collections::{BinaryHeap, HashMap};
use std::cmp::Reverse;

struct TaskManager {
    tasks: HashMap<i32, i32>,
    priority_queue: BinaryHeap<(Reverse<i32>, i32)>,
    timestamp: i32,
}

impl TaskManager {
    fn new() -> Self {
        TaskManager {
            tasks: HashMap::new(),
            priority_queue: BinaryHeap::new(),
            timestamp: 0,
        }
    }

    fn add_task(&mut self, priority: i32) -> i32 {
        self.timestamp += 1;
        self.tasks.insert(self.timestamp, priority);
        self.priority_queue.push((Reverse(priority), self.timestamp));
        self.timestamp
    }

    fn peek_task(&mut self) -> i32 {
        while let Some(&(Reverse(priority), task_id)) = self.priority_queue.peek() {
            if let Some(&stored_priority) = self.tasks.get(&task_id) {
                if stored_priority == priority {
                    return task_id;
                } else {
                    self.priority_queue.pop();
                }
            } else {
                self.priority_queue.pop();
            }
        }
        -1
    }

    fn pull_task(&mut self) -> i32 {
        while let Some(&(Reverse(priority), task_id)) = self.priority_queue.peek() {
            if let Some(&stored_priority) = self.tasks.get(&task_id) {
                if stored_priority == priority {
                    self.tasks.remove(&task_id);
                    self.priority_queue.pop();
                    return task_id;
                } else {
                    self.priority_queue.pop();
                }
            } else {
                self.priority_queue.pop();
            }
        }
        -1
    }
}