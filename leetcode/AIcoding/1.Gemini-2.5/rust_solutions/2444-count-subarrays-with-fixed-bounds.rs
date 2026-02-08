impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, min_k: i32, max_k: i32) -> i64 {
        let n = nums.len();
        let mut count: i64 = 0;
        let mut last_invalid_idx: i32 = -1;
        let mut last_min_idx: i32 = -1;
        let mut last_max_idx: i32 = -1;

        for i in 0..n {
            let num = nums[i];
            let current_idx = i as i32;

            if num < min_k || num > max_k {
                last_invalid_idx = current_idx;
            } else {
                if num == min_k {
                    last_min_idx = current_idx;
                }
                if num == max_k {
                    last_max_idx = current_idx;
                }

                count += std::cmp::max(0, std::cmp::min(last_min_idx, last_max_idx) - last_invalid_idx);
            }
        }

        count
    }
}