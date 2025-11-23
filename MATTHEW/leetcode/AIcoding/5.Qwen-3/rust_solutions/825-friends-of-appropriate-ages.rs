impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_friends(ages: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &age in &ages {
            *count.entry(age).or_insert(0) += 1;
        }

        let mut result = 0;
        for (&age, &cnt) in &count {
            if age > 14 {
                for (&other_age, &other_cnt) in &count {
                    if other_age > 14 && other_age <= age && other_age > age / 2 {
                        result += cnt * other_cnt;
                    }
                }
            }
        }

        result
    }
}
}