impl Solution {
    pub fn count_balls(low_limit: i32, high_limit: i32) -> i32 {
        use std::collections::HashMap;

        let mut counts: HashMap<i32, i32> = HashMap::new();

        for i in low_limit..=high_limit {
            let mut sum = 0;
            let mut num = i;
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }

            *counts.entry(sum).or_insert(0) += 1;
        }

        *counts.values().max().unwrap_or(&0)
    }
}