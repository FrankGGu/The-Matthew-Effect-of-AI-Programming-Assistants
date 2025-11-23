impl Solution {
    pub fn maximum_difference(nums: Vec<i32>) -> i32 {
        let mut max_diff = -1;
        let n = nums.len();

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let diff = (nums[i] - nums[j]).abs();
                    if (nums[i] % 2 == 0 && nums[j] % 2 == 1) || (nums[i] % 2 == 1 && nums[j] % 2 == 0) {
                        max_diff = max_diff.max(diff);
                    }
                }
            }
        }

        max_diff
    }
}