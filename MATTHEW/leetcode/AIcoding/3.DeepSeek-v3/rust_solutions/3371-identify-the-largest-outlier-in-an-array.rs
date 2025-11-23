impl Solution {
    pub fn identify_largest_outlier(nums: Vec<i32>) -> i32 {
        let mean = nums.iter().sum::<i32>() as f64 / nums.len() as f64;
        nums.iter()
            .max_by(|&&a, &&b| {
                let diff_a = (a as f64 - mean).abs();
                let diff_b = (b as f64 - mean).abs();
                diff_a.partial_cmp(&diff_b).unwrap()
            })
            .copied()
            .unwrap()
    }
}