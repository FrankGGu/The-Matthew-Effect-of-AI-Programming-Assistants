impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_arithmetic_subarrays(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let n = nums.len();
        let mut result = Vec::new();

        for i in 0..n {
            for j in i + 1..n {
                let mut is_arithmetic = true;
                let diff = nums[j] - nums[i];
                let mut current = vec![nums[i], nums[j]];
                let mut prev = nums[j];

                for k in j + 1..n {
                    if nums[k] - prev == diff {
                        current.push(nums[k]);
                        prev = nums[k];
                    } else {
                        is_arithmetic = false;
                        break;
                    }
                }

                if is_arithmetic && current.len() >= 2 {
                    result.push(current);
                }
            }
        }

        result
    }
}
}