impl Solution {
    pub fn four_sum(mut nums: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let n = nums.len();
        if n < 4 {
            return vec![];
        }

        nums.sort_unstable();

        let mut result = Vec::new();

        for i in 0..n - 3 {
            if i > 0 && nums[i] == nums[i - 1] {
                continue;
            }

            for j in i + 1..n - 2 {
                if j > i + 1 && nums[j] == nums[j - 1] {
                    continue;
                }

                let mut left = j + 1;
                let mut right = n - 1;

                let target_long = target as i64;

                while left < right {
                    let current_sum = nums[i] as i64 + nums[j] as i64 + nums[left] as i64 + nums[right] as i64;

                    if current_sum == target_long {
                        result.push(vec![nums[i], nums[j], nums[left], nums[right]]);

                        while left < right && nums[left] == nums[left + 1] {
                            left += 1;
                        }
                        while left < right && nums[right] == nums[right - 1] {
                            right -= 1;
                        }

                        left += 1;
                        right -= 1;
                    } else if current_sum < target_long {
                        left += 1;
                    } else {
                        right -= 1;
                    }
                }
            }
        }

        result
    }
}