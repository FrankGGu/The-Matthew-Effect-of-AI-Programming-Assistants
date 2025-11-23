impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut diff = nums[1] - nums[0];
        let mut operations = 0;

        for i in 2..n {
            let current_diff = nums[i] - nums[i - 1];
            if current_diff != diff {
                if i == n - 1 {
                    operations += 1;
                } else {
                    let next_diff = nums[i + 1] - nums[i];
                    if current_diff + next_diff == 2 * diff {
                        operations += 1;
                        nums[i] = nums[i - 1] + diff;
                    } else {
                        return -1;
                    }
                }
            }
        }

        operations
    }
}