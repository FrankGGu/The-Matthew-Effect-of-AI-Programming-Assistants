impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn three_sum_multisets(arr: Vec<i32>, target: i32) -> i32 {
        let mut count = HashMap::new();
        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        let keys: Vec<i32> = count.keys().cloned().collect();

        for i in 0..keys.len() {
            let a = keys[i];
            let mut a_count = count[&a];

            if a * 3 == target {
                if a_count >= 3 {
                    result += (a_count * (a_count - 1) * (a_count - 2)) / 6;
                }
                continue;
            }

            if a * 2 < target {
                let b = target - 2 * a;
                if let Some(&b_count) = count.get(&b) {
                    result += a_count * b_count;
                }
            }

            for j in i + 1..keys.len() {
                let b = keys[j];
                let c = target - a - b;
                if c < b {
                    continue;
                }
                if c == b {
                    if let Some(&b_count) = count.get(&b) {
                        result += a_count * b_count;
                    }
                } else {
                    if let Some(&c_count) = count.get(&c) {
                        result += a_count * count[&b] * c_count;
                    }
                }
            }
        }

        result
    }
}
}