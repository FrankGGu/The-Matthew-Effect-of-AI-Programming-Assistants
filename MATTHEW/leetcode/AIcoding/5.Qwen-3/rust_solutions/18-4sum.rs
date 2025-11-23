impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn four_sum(mut nums: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let n = nums.len();
        let mut result = Vec::new();
        if n < 4 {
            return result;
        }
        nums.sort();
        for i in 0..n - 3 {
            if i > 0 && nums[i] == nums[i - 1] && nums[i - 1] == nums[i - 2] {
                continue;
            }
            for j in i + 1..n - 2 {
                if j > i + 1 && nums[j] == nums[j - 1] && nums[j - 1] == nums[j - 2] {
                    continue;
                }
                let (mut left, mut right) = (j + 1, n - 1);
                while left < right {
                    let sum = nums[i] + nums[j] + nums[left] + nums[right];
                    if sum == target {
                        result.push(vec![nums[i], nums[j], nums[left], nums[right]]);
                        while left < right && nums[left] == nums[left + 1] {
                            left += 1;
                        }
                        while left < right && nums[right] == nums[right - 1] {
                            right -= 1;
                        }
                        left += 1;
                        right -= 1;
                    } else if sum < target {
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
}