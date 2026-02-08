use std::collections::HashMap;

impl Solution {
    pub fn find_original_array(mut changed: Vec<i32>) -> Vec<i32> {
        let n = changed.len();
        if n % 2 != 0 {
            return vec![];
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &changed {
            *counts.entry(num).or_insert(0) += 1;
        }

        changed.sort_unstable();

        let mut original_array: Vec<i32> = Vec::with_capacity(n / 2);

        for num in changed {
            if let Some(count) = counts.get_mut(&num) {
                if *count == 0 {
                    continue;
                }
                *count -= 1;
            } else {
                continue; 
            }

            let doubled_num = num * 2;

            if let Some(doubled_count) = counts.get_mut(&doubled_num) {
                if *doubled_count > 0 {
                    *doubled_count -= 1;
                    original_array.push(num);
                } else {
                    return vec![];
                }
            } else {
                return vec![];
            }
        }

        original_array
    }
}