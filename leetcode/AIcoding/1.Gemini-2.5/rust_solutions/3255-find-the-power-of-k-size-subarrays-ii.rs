impl Solution {
    pub fn find_the_power_of_k_size_subarrays(nums: Vec<i32>, k: i32) -> Vec<i64> {
        let n = nums.len();
        let k_usize = k as usize;

        if n < k_usize {
            return Vec::new();
        }

        let mut ans: Vec<i64> = Vec::with_capacity(n - k_usize + 1);
        let mut current_power: i64 = 0;

        for i in 0..k_usize {
            current_power += (nums[i] % k) as i64;
        }
        ans.push(current_power);

        for i in k_usize..n {
            current_power -= (nums[i - k_usize] % k) as i64;
            current_power += (nums[i] % k) as i64;
            ans.push(current_power);
        }

        ans
    }
}