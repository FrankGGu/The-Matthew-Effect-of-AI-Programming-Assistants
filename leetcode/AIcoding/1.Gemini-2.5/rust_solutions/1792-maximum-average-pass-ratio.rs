use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Debug, Clone, Copy)]
struct Class {
    p: i32,
    t: i32,
    gain: f64,
}

impl Class {
    fn new(p_val: i32, t_val: i32) -> Self {
        let gain = Self::calculate_gain(p_val, t_val);
        Class { p: p_val, t: t_val, gain }
    }

    fn calculate_gain(p_val: i32, t_val: i32) -> f64 {
        let current_ratio = p_val as f64 / t_val as f64;
        let new_ratio = (p_val + 1) as f64 / (t_val + 1) as f64;
        new_ratio - current_ratio
    }

    fn apply_student(&mut self) {
        self.p += 1;
        self.t += 1;
        self.gain = Self::calculate_gain(self.p, self.t);
    }
}

impl PartialEq for Class {
    fn eq(&self, other: &Self) -> bool {
        self.gain.to_bits() == other.gain.to_bits()
    }
}

impl Eq for Class {}

impl PartialOrd for Class {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.gain.total_cmp(&other.gain))
    }
}

impl Ord for Class {
    fn cmp(&self, other: &Self) -> Ordering {
        self.partial_cmp(other).unwrap_or(Ordering::Equal)
    }
}

struct Solution;

impl Solution {
    pub fn max_average_pass_ratio(classes: Vec<Vec<i32>>, extra_students: i32) -> f64 {
        let mut heap = BinaryHeap::new();

        for class_data in classes.iter() {
            let p = class_data[0];
            let t = class_data[1];
            heap.push(Class::new(p, t));
        }

        for _ in 0..extra_students {
            if let Some(mut class) = heap.pop() {
                class.apply_student();
                heap.push(class);
            } else {
                break; 
            }
        }

        let mut total_ratio_sum = 0.0;
        let num_classes = heap.len() as f64;

        while let Some(class) = heap.pop() {
            total_ratio_sum += class.p as f64 / class.t as f64;
        }

        total_ratio_sum / num_classes
    }
}