use std::collections::BinaryHeap;

#[derive(PartialEq, PartialOrd)]
struct Class {
    pass: i32,
    total: i32,
}

impl Eq for Class {}

impl Ord for Class {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        let self_improvement = (self.pass + 1) as f64 / (self.total + 1) as f64 - (self.pass) as f64 / (self.total) as f64;
        let other_improvement = (other.pass + 1) as f64 / (other.total + 1) as f64 - (other.pass) as f64 / (other.total) as f64;
        self_improvement.partial_cmp(&other_improvement).unwrap()
    }
}

impl Solution {
    pub fn max_average_ratio(classes: Vec<Vec<i32>>, extra_students: i32) -> f64 {
        let mut heap = BinaryHeap::new();
        for class in classes {
            heap.push(Class {
                pass: class[0],
                total: class[1],
            });
        }

        for _ in 0..extra_students {
            if let Some(mut c) = heap.pop() {
                c.pass += 1;
                c.total += 1;
                heap.push(c);
            }
        }

        let mut total_ratio = 0.0;
        while let Some(c) = heap.pop() {
            total_ratio += c.pass as f64 / c.total as f64;
        }

        total_ratio / classes.len() as f64
    }
}