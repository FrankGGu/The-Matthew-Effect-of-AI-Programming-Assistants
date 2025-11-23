impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn max_xor_subarray(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut res = Vec::new();

        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let mut max_xor = 0;
            let mut current = 0;

            for i in l..=r {
                current ^= nums[i];
                max_xor = max(max_xor, current);
            }

            res.push(max_xor);
        }

        res
    }
}
}