impl Solution {
    pub fn good_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut left = vec![1; n];
        let mut right = vec![1; n];

        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                left[i] = left[i - 1] + 1;
            }
        }

        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                right[i] = right[i + 1] + 1;
            }
        }

        let mut res = Vec::new();
        for i in k..n - k {
            if left[i - 1] >= k as i32 && right[i + 1] >= k as i32 {
                res.push(i as i32);
            }
        }

        res
    }
}