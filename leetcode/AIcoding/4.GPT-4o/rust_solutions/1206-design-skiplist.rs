use std::collections::HashMap;
use rand::Rng;

const MAX_LEVEL: usize = 16;

struct Skiplist {
    head: Box<Node>,
    level: usize,
}

struct Node {
    value: i32,
    next: Vec<Option<Box<Node>>>,
}

impl Skiplist {
    fn new() -> Self {
        Skiplist {
            head: Box::new(Node {
                value: i32::MIN,
                next: vec![None; MAX_LEVEL],
            }),
            level: 0,
        }
    }

    fn random_level() -> usize {
        let mut rng = rand::thread_rng();
        let mut level = 0;
        while level < MAX_LEVEL && rng.gen_bool(0.5) {
            level += 1;
        }
        level
    }

    fn search(&self, target: i32) -> bool {
        let mut current = &self.head;
        for i in (0..self.level + 1).rev() {
            while let Some(ref next) = current.next[i] {
                if next.value < target {
                    current = next;
                } else {
                    break;
                }
            }
        }
        current.next[0].as_ref().map_or(false, |node| node.value == target)
    }

    fn add(&mut self, num: i32) {
        let mut update = vec![None; MAX_LEVEL];
        let mut current = &self.head;

        for i in (0..self.level + 1).rev() {
            while let Some(ref next) = current.next[i] {
                if next.value < num {
                    current = next;
                } else {
                    break;
                }
            }
            update[i] = Some(current);
        }

        let new_level = Self::random_level();
        if new_level > self.level {
            for i in self.level + 1..=new_level {
                update[i] = Some(&self.head);
            }
            self.level = new_level;
        }

        let new_node = Box::new(Node {
            value: num,
            next: vec![None; MAX_LEVEL],
        });

        for i in 0..=new_level {
            let next = update[i].as_ref().and_then(|node| node.next[i].take());
            new_node.next[i] = next;
            if let Some(node) = update[i] {
                node.next[i] = Some(new_node.clone());
            }
        }
    }

    fn erase(&mut self, num: i32) -> bool {
        let mut update = vec![None; MAX_LEVEL];
        let mut current = &self.head;

        for i in (0..self.level + 1).rev() {
            while let Some(ref next) = current.next[i] {
                if next.value < num {
                    current = next;
                } else {
                    break;
                }
            }
            update[i] = Some(current);
        }

        if let Some(next) = current.next[0].as_ref() {
            if next.value == num {
                for i in 0..=self.level {
                    if let Some(node) = update[i] {
                        if node.next[i].as_ref() == Some(&current.next[i]) {
                            node.next[i] = next.next[i].clone();
                        }
                    }
                }

                while self.level > 0 && self.head.next[self.level].is_none() {
                    self.level -= 1;
                }
                return true;
            }
        }
        false
    }
}