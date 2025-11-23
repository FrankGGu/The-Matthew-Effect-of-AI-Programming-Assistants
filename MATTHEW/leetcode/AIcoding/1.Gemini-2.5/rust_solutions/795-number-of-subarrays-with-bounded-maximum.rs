impl Solution {
    fn count_less_equal(nums: &[i32], k: i32) -> i32 {
        let mut ans = 0;
        let mut current_len = 0;
        for &num in nums {
            if num <= k {
                current_len += 1;
                ans += current_len;
            } else {
                current_len = 0;
            }
        }
        ans
    }

    pub fn num_subarray_bounded_max(nums: Vec<i32>, l: i32, r: i32) -> i32 {
        Self::count_less_equal(&nums, r) - Self::count_less_equal(&nums, l - 1)
    }
}