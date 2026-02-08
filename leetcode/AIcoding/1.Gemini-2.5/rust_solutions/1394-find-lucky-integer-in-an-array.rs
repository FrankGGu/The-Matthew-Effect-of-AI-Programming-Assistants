use std::collections::HashMap;

impl Solution {
    pub fn find_lucky(arr: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in arr.iter() {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut max_lucky = -1;

        for (&num, &freq) in counts.iter() {
            if num == freq {
                if num > max_lucky {
                    max_lucky = num;
                }
            }
        }

        max_lucky
    }
}