use std::collections::HashSet;

impl Solution {
    pub fn max_count(banned: Vec<i32>, n: i32, max_sum: i32) -> i32 {
        let banned_set: HashSet<i32> = banned.into_iter().collect();
        let mut sum = 0;
        let mut count = 0;

        for num in 1..=n {
            if !banned_set.contains(&num) && sum + num <= max_sum {
                sum += num;
                count += 1;
            }
        }

        count
    }
}