use std::collections::HashSet;

impl Solution {
    pub fn median_of_uniqueness_array(nums: Vec<i32>) -> f64 {
        let mut unique_nums: HashSet<i32> = HashSet::new();
        for &num in &nums {
            unique_nums.insert(num);
        }

        let mut unique_vec: Vec<i32> = unique_nums.into_iter().collect();
        unique_vec.sort();

        let n = unique_vec.len();
        if n % 2 == 0 {
            (unique_vec[n / 2 - 1] as f64 + unique_vec[n / 2] as f64) / 2.0
        } else {
            unique_vec[n / 2] as f64
        }
    }
}