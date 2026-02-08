use std::collections::HashMap;

impl Solution {
    pub fn is_possible(nums: Vec<i32>) -> bool {
        let mut freq = HashMap::new();
        let mut need = HashMap::new();

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &num in &nums {
            if freq.get(&num).map_or(0, |&f| f) == 0 {
                continue;
            }

            if need.get(&num).map_or(0, |&n| n) > 0 {
                *freq.entry(num).or_insert(0) -= 1;
                *need.entry(num).or_insert(0) -= 1;
                *need.entry(num + 1).or_insert(0) += 1;
            } else if freq.get(&(num + 1)).map_or(0, |&f| f) > 0 && freq.get(&(num + 2)).map_or(0, |&f| f) > 0 {
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