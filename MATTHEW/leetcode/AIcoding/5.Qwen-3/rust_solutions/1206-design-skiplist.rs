impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

struct Skiplist {
    levels: Vec<VecDeque<(i32, i32)>>,
}

impl Skiplist {
    fn new() -> Self {
        Skiplist {
            levels: vec![VecDeque::new()],
        }
    }

    fn search(&self, target: i32) -> bool {
        let mut curr = self.levels[0].front();
        while let Some(&(val, _)) = curr {
            match val.cmp(&target) {
                Ordering::Equal => return true,
                Ordering::Less => {
                    curr = self.levels[0].next();
                }
                Ordering::Greater => break,
            }
        }
        false
    }

    fn add(&mut self, num: i32) {
        let mut curr = self.levels[0].front_mut();
        let mut level = 0;
        let mut node = (num, 1);
        while let Some(&(val, count)) = curr.as_ref() {
            if val == num {
                *curr.as_mut().unwrap() = (val, count + 1);
                return;
            } else if val > num {
                break;
            }
            curr = self.levels[0].next();
        }
        self.levels[0].push_front(node);

        while rand::random::<bool>() && level < self.levels.len() - 1 {
            level += 1;
            if self.levels.len() <= level {
                self.levels.push(VecDeque::new());
            }
            let mut curr = self.levels[level].front_mut();
            while let Some(&(val, _)) = curr.as_ref() {
                if val == num {
                    *curr.as_mut().unwrap() = (val, 1);
                    return;
                } else if val > num {
                    break;
                }
                curr = self.levels[level].next();
            }
            self.levels[level].push_front((num, 1));
        }
    }

    fn erase(&mut self, num: i32) -> bool {
        let mut found = false;
        for level in 0..self.levels.len() {
            let mut curr = self.levels[level].front_mut();
            while let Some(&(val, count)) = curr.as_ref() {
                if val == num {
                    if count > 1 {
                        *curr.as_mut().unwrap() = (val, count - 1);
                    } else {
                        self.levels[level].remove(curr.as_ref().unwrap());
                    }
                    found = true;
                    break;
                } else if val > num {
                    break;
                }
                curr = self.levels[level].next();
            }
        }
        found
    }
}
}