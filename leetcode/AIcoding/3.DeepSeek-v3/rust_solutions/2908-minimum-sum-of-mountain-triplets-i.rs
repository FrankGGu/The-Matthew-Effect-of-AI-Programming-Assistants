impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_sum = i32::MAX;

        for i in 0..n {
            for j in (i + 1)..n {
                for k in (j + 1)..n {
                    if nums[i] < nums[j] && nums[k] < nums[j] {
                        let sum = nums[i] + nums[j] + nums[k];
                        if sum < min_sum {
                            min_sum = sum;
                        }
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