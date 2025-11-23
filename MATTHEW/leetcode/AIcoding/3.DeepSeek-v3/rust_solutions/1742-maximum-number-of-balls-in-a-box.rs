impl Solution {
    pub fn count_balls(low_limit: i32, high_limit: i32) -> i32 {
        use std::collections::HashMap;
        let mut box_counts = HashMap::new();

        for num in low_limit..=high_limit {
            let mut sum = 0;
            let mut n = num;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            *box_counts.entry(sum).or_insert(0) += 1;
        }

        *box_counts.values().max().unwrap_or(&0)
    }
}