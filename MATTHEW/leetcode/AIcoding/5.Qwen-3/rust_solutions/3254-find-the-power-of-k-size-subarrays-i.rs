struct Solution;

impl Solution {
    pub fn pow_k_subarrays(nums: Vec<i32>, k: i32) -> Vec<i64> {
        let k = k as usize;
        let n = nums.len();
        let mut result = Vec::new();

        for i in 0..=n - k {
            let mut power = 1;
            for j in i..i + k {
                power *= nums[j] as i64;
            }
            result.push(power);
        }

        result
    }
}