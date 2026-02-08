impl Solution {
    pub fn count_k_size_subarrays_with_power(nums: Vec<i32>, k: i32, power: i32) -> i32 {
        let k = k as usize;
        let mut count = 0;
        let n = nums.len();

        for i in 0..=n - k {
            let mut sum = 0;
            for j in i..i + k {
                sum += nums[j];
            }
            if sum.pow(2) == power {
                count += 1;
            }
        }

        count
    }
}