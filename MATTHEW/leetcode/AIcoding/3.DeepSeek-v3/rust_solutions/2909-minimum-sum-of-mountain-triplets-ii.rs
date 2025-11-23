impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return -1;
        }

        let mut left_min = vec![i32::MAX; n];
        let mut right_min = vec![i32::MAX; n];

        left_min[0] = nums[0];
        for i in 1..n {
            left_min[i] = left_min[i-1].min(nums[i]);
        }

        right_min[n-1] = nums[n-1];
        for i in (0..n-1).rev() {
            right_min[i] = right_min[i+1].min(nums[i]);
        }

        let mut min_sum = i32::MAX;
        for j in 1..n-1 {
            if nums[j] > left_min[j-1] && nums[j] > right_min[j+1] {
                min_sum = min_sum.min(left_min[j-1] + nums[j] + right_min[j+1]);
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}