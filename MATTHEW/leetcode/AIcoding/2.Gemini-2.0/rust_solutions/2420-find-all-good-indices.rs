impl Solution {
    pub fn good_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut non_decreasing = vec![0; n];
        let mut non_increasing = vec![0; n];

        non_decreasing[0] = 1;
        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                non_decreasing[i] = non_decreasing[i - 1] + 1;
            } else {
                non_decreasing[i] = 1;
            }
        }

        non_increasing[n - 1] = 1;
        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                non_increasing[i] = non_increasing[i + 1] + 1;
            } else {
                non_increasing[i] = 1;
            }
        }

        let mut result = Vec::new();
        for i in k..n - k {
            if non_decreasing[i - 1] >= k && non_increasing[i + 1] >= k {
                result.push(i as i32);
            }
        }

        result
    }
}