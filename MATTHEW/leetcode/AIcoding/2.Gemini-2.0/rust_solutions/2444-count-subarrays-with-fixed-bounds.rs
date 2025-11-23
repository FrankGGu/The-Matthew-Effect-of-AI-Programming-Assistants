impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, min_k: i32, max_k: i32) -> i64 {
        let n = nums.len();
        let mut ans = 0;
        let mut left_bound = -1;
        let mut last_min = -1;
        let mut last_max = -1;

        for i in 0..n {
            if nums[i] < min_k || nums[i] > max_k {
                left_bound = i as i32;
                last_min = -1;
                last_max = -1;
            }

            if nums[i] == min_k {
                last_min = i as i32;
            }

            if nums[i] == max_k {
                last_max = i as i32;
            }

            if last_min != -1 && last_max != -1 {
                ans += (std::cmp::min(last_min, last_max) - left_bound) as i64;
            }
        }

        ans
    }
}