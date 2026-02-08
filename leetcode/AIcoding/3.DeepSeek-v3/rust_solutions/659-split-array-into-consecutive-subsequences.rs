use std::collections::HashMap;

impl Solution {
    pub fn is_possible(nums: Vec<i32>) -> bool {
        let mut freq = HashMap::new();
        let mut need = HashMap::new();

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &num in &nums {
            if *freq.get(&num).unwrap() == 0 {
                continue;
            }

            if let Some(&count) = need.get(&num) {
                if count > 0 {
                    *freq.entry(num).or_insert(0) -= 1;
                    *need.entry(num).or_insert(0) -= 1;
                    *need.entry(num + 1).or_insert(0) += 1;
                    continue;
                }
            }

            if *freq.get(&num).unwrap() > 0 
                && *freq.get(&(num + 1)).unwrap_or(&0) > 0 
                && *freq.get(&(num + 2)).unwrap_or(&0) > 0 {
                *freq.entry(num).or_insert(0) -= 1;
                *freq.entry(num + 1).or_insert(0) -= 1;
                *freq.entry(num + 2).or_insert(0) -= 1;
                *need.entry(num + 3).or_insert(0) += 1;
            } else {
                return false;
            }
        }

        true
    }
}