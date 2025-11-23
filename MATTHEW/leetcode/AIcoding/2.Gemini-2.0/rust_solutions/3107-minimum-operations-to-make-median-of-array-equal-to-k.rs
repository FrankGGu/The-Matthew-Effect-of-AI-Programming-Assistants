impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut less = 0;
        let mut greater = 0;
        for &num in &nums {
            if num < k {
                less += 1;
            } else if num > k {
                greater += 1;
            }
        }
        let median_index = (n + 1) / 2;
        let need_k = median_index;
        let have_k = n - less - greater;
        let need_greater = median_index - have_k;
        return std::cmp::max(0, need_greater as i64 + less as i64);
    }
}