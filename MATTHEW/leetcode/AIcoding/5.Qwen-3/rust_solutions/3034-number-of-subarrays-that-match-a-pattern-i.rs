impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pat: Vec<char>) -> i32 {
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            map.insert(num, i);
        }

        let mut res = 0;
        let len = pat.len();
        for i in 0..nums.len() - len + 1 {
            let mut match_flag = true;
            for j in 0..len {
                let a = nums[i + j];
                let b = nums[i + j + 1];
                let p = pat[j];
                if p == '>' && a >= b {
                    match_flag = false;
                    break;
                } else if p == '<' && a <= b {
                    match_flag = false;
                    break;
                }
            }
            if match_flag {
                res += 1;
            }
        }
        res
    }
}
}