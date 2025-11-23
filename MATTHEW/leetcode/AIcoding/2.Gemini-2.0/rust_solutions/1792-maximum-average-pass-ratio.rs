use std::collections::BinaryHeap;

impl Solution {
    pub fn max_average_ratio(mut classes: Vec<Vec<i32>>, extra_students: i32) -> f64 {
        let mut heap = BinaryHeap::new();
        for class in &classes {
            let pass = class[0] as f64;
            let total = class[1] as f64;
            let diff = (pass + 1.0) / (total + 1.0) - pass / total;
            heap.push(FloatOrd(diff, class[0], class[1]));
        }

        for _ in 0..extra_students {
            if let Some(FloatOrd(_, pass, total)) = heap.pop() {
                let pass = pass as i32;
                let total = total as i32;
                classes.retain(|c| c[0] != pass || c[1] != total);
                classes.push(vec![pass + 1, total + 1]);
                let pass = (pass + 1) as f64;
                let total = (total + 1) as f64;
                let diff = (pass + 1.0) / (total + 1.0) - pass / total;
                heap.push(FloatOrd(diff, pass as i32, total as i32));
            }
        }

        let mut sum = 0.0;
        for class in &classes {
            sum += class[0] as f64 / class[1] as f64;
        }

        sum / classes.len() as f64
    }
}

struct FloatOrd(f64, i32, i32);

impl PartialEq for FloatOrd {
    fn eq(&self, other: &Self) -> bool {
        self.0 == other.0
    }
}

impl Eq for FloatOrd {}

impl PartialOrd for FloatOrd {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        self.0.partial_cmp(&other.0)
    }
}

impl Ord for FloatOrd {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.partial_cmp(other).unwrap().reverse()
    }
}