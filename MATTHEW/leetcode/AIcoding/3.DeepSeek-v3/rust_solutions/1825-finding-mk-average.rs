use std::collections::{BTreeSet, VecDeque};

struct MKAverage {
    m: usize,
    k: usize,
    queue: VecDeque<i32>,
    lower: BTreeSet<(i32, usize)>,
    middle: BTreeSet<(i32, usize)>,
    upper: BTreeSet<(i32, usize)>,
    sum: i64,
    id: usize,
}

impl MKAverage {
    fn new(m: i32, k: i32) -> Self {
        MKAverage {
            m: m as usize,
            k: k as usize,
            queue: VecDeque::new(),
            lower: BTreeSet::new(),
            middle: BTreeSet::new(),
            upper: BTreeSet::new(),
            sum: 0,
            id: 0,
        }
    }

    fn add_element(&mut self, num: i32) {
        self.id += 1;
        self.queue.push_back(num);
        if self.queue.len() > self.m {
            let removed = self.queue.pop_front().unwrap();
            if self.lower.remove(&(removed, self.id - self.m)) {
                if let Some(&(val, id)) = self.middle.iter().next() {
                    self.middle.remove(&(val, id));
                    self.lower.insert((val, id));
                    self.sum -= val as i64;
                }
            } else if self.middle.remove(&(removed, self.id - self.m)) {
                self.sum -= removed as i64;
                if let Some(&(val, id)) = self.upper.iter().next() {
                    self.upper.remove(&(val, id));
                    self.middle.insert((val, id));
                    self.sum += val as i64;
                }
            } else {
                self.upper.remove(&(removed, self.id - self.m));
            }
        }

        self.lower.insert((num, self.id));
        if self.lower.len() > self.k {
            let &(val, id) = self.lower.iter().rev().next().unwrap();
            self.lower.remove(&(val, id));
            self.middle.insert((val, id));
            self.sum += val as i64;
        }
        if self.middle.len() > self.m - 2 * self.k {
            let &(val, id) = self.middle.iter().rev().next().unwrap();
            self.middle.remove(&(val, id));
            self.sum -= val as i64;
            self.upper.insert((val, id));
        }
    }

    fn calculate_mk_average(&self) -> i32 {
        if self.queue.len() < self.m {
            -1
        } else {
            (self.sum / (self.m - 2 * self.k) as i64) as i32
        }
    }
}