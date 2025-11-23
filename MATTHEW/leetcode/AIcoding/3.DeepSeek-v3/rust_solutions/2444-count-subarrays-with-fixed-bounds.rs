impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, min_k: i32, max_k: i32) -> i64 {
        let mut res = 0i64;
        let mut min_pos = -1i64;
        let mut max_pos = -1i64;
        let mut left_bound = -1i64;

        for (i, &num) in nums.iter().enumerate() {
            let i = i as i64;
            if num < min_k || num > max_k {
                left_bound = i;
            }
            if num == min_k {
                min_pos = i;
            }
            if num == max_k {
                max_pos = i;
            }
            res += 0.max(min_pos.min(max_pos) - left_bound);
        }

        res
    }
}