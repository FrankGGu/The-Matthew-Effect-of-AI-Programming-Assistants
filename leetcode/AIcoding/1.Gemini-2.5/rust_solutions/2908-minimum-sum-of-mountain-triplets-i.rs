impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_sum = i32::MAX;

        for j in 1..n - 1 {
            for i in 0..j {
                for k in j + 1..n {
                    if nums[i] < nums[j] && nums[k] < nums[j] {
                        min_sum = min_sum.min(nums[i] + nums[j] + nums[k]);
                    }
                }
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}