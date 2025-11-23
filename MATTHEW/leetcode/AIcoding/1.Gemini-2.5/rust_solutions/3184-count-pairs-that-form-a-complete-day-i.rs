impl Solution {
    pub fn count_complete_day_pairs(hours: Vec<i32>) -> i32 {
        let mut remainder_counts = vec![0; 24];
        let mut count = 0;

        for hour in hours {
            let remainder = (hour % 24) as usize;
            let complement_remainder = (24 - remainder) % 24;

            count += remainder_counts[complement_remainder];
            remainder_counts[remainder] += 1;
        }

        count
    }
}