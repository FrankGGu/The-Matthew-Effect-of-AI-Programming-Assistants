impl Solution {
    pub fn find_power_of_k_subarrays(nums: Vec<i32>, k: i32) -> Vec<i64> {
        let n = nums.len();
        let k_usize = k as usize;
        let mut ans: Vec<i64> = Vec::new();

        if n == 0 || k_usize == 0 || k_usize > n {
            return ans;
        }

        let mut current_sum: i64 = 0;

        for i in 0..k_usize {
            current_sum += nums[i] as i64;
        }
        ans.push(current_sum);

        for i in k_usize..n {
            current_sum -= nums[i - k_usize] as i64;
            current_sum += nums[i] as i64;
            ans.push(current_sum);
        }

        ans
    }
}