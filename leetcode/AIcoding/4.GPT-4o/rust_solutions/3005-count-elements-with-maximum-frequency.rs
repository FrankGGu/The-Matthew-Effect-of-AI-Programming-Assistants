impl Solution {
    pub fn count_max_frequency(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut frequency = HashMap::new();
        let mut max_freq = 0;

        for &num in &nums {
            let count = frequency.entry(num).or_insert(0);
            *count += 1;
            max_freq = max_freq.max(*count);
        }

        frequency.values().filter(|&&count| count == max_freq).count() as i32
    }
}