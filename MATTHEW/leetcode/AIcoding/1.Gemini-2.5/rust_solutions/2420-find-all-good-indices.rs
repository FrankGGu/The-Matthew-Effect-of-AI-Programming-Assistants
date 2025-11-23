impl Solution {
    pub fn good_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;

        if n < 2 * k + 1 {
            return Vec::new();
        }

        let mut left_non_increasing = vec![1; n];
        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                left_non_increasing[i] = left_non_increasing[i - 1] + 1;
            }
        }

        let mut right_non_decreasing = vec![1; n];
        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                right_non_decreasing[i] = right_non_decreasing[i + 1] + 1;
            }
        }

        let mut result = Vec::new();
        for i in k..(n - k) {
            if left_non_increasing[i - 1] >= k && right_non_decreasing[i + 1] >= k {
                result.push(i as i32);
            }
        }

        result
    }
}