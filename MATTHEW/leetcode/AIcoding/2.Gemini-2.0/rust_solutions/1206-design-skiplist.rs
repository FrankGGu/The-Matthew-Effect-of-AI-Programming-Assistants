use rand::Rng;

struct Node {
    val: i32,
    forward: Vec<Option<Box<Node>>>,
}

impl Node {
    fn new(val: i32, level: usize) -> Self {
        Node {
            val,
            forward: vec![None; level],
        }
    }
}

struct Skiplist {
    max_level: usize,
    p: f64,
    level: usize,
    head: Node,
}

impl Skiplist {
    fn new() -> Self {
        let max_level = 32;
        let p = 0.5;
        Skiplist {
            max_level,
            p,
            level: 1,
            head: Node::new(-1, max_level),
        }
    }

    fn random_level(&self) -> usize {
        let mut level = 1;
        let mut rng = rand::thread_rng();
        while rng.gen_range(0.0..1.0) < self.p && level < self.max_level {
            level += 1;
        }
        level
    }

    fn search(&self, target: i32) -> bool {
        let mut curr = &self.head;
        for i in (0..self.level).rev() {
            while let Some(next) = &curr.forward[i] {
                if next.val < target {
                    curr = next;
                } else {
                    break;
                }
            }
        }

        if let Some(next) = &curr.forward[0] {
            next.val == target
        } else {
            false
        }
    }

    fn add(&mut self, num: i32) {
        let level = self.random_level();
        if level > self.level {
            for i in self.level..level {
                self.head.forward[i] = None;
            }
            self.level = level;
        }

        let mut update: Vec<Option<Box<Node>>> = vec![None; self.max_level];
        let mut curr = &mut self.head;

        for i in (0..self.level).rev() {
            while let Some(next) = &curr.forward[i] {
                if next.val < num {
                    curr = unsafe { &mut *(&**next as *const Node as *mut Node) };
                } else {
                    break;
                }
            }
            update[i] = Some(Box::new(Node::new(curr.val, self.max_level)));
            update[i].as_mut().unwrap().forward[i] = curr.forward[i].take();
        }

        let new_node = Box::new(Node::new(num, level));
        let mut curr = &mut self.head;

        for i in (0..level).rev() {
            while let Some(next) = &curr.forward[i] {
                if next.val < num {
                    curr = unsafe { &mut *(&**next as *const Node as *mut Node) };
                } else {
                    break;
                }
            }

            let temp = curr.forward[i].take();
            curr.forward[i] = Some(new_node.clone());
            new_node.forward[i] = temp;
        }

    }

    fn erase(&mut self, num: i32) -> bool {
        let mut update: Vec<Option<Box<Node>>> = vec![None; self.max_level];
        let mut curr = &mut self.head;
        for i in (0..self.level).rev() {
            while let Some(next) = &curr.forward[i] {
                if next.val < num {
                    curr = unsafe { &mut *(&**next as *const Node as *mut Node) };
                } else {
                    break;
                }
            }
            update[i] = Some(Box::new(Node::new(curr.val, self.max_level)));
            update[i].as_mut().unwrap().forward[i] = curr.forward[i].take();
        }

        if let Some(next) = &curr.forward[0] {
            if next.val == num {
                let mut curr = &mut self.head;
                for i in (0..self.level).rev() {
                    while let Some(next) = &curr.forward[i] {
                        if next.val < num {
                            curr = unsafe { &mut *(&**next as *const Node as *mut Node) };
                        } else {
                            break;
                        }
                    }
                    if let Some(next) = &curr.forward[i] {
                        if next.val == num {
                            curr.forward[i] = next.forward[i].take();
                        }
                    }
                }

                while self.level > 1 && self.head.forward[self.level - 1].is_none() {
                    self.level -= 1;
                }

                return true;
            }
        }

        false
    }
}