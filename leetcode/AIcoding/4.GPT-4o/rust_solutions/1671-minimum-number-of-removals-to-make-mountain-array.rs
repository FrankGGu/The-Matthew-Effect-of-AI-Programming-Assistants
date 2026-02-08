impl Solution {
    pub fn minimum_mountain_removals(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = vec![1; n];
        let mut right = vec![1; n];

        for i in 1..n {
            for j in 0..i {
                if nums[i] > nums[j] {
                    left[i] = left[i].max(left[j] + 1);
                }
            }
        }

        for i in (0..n - 1).rev() {
            for j in (i + 1)..n {
                if nums[i] > nums[j] {
                    right[i] = right[i].max(right[j] + 1);
                }
            }
        }

        let mut max_mountain_length = 0;
        for i in 1..n - 1 {
            if left[i] > 1 && right[i] > 1 {
                max_mountain_length = max_mountain_length.max(left[i] + right[i] - 1);
            }
        }

        n as i32 - max_mountain_length as i32
    }
}