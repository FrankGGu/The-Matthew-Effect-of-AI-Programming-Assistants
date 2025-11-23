impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn beautiful_indices(nums: Vec<i32>, s: String, k: i32) -> Vec<i32> {
        let mut indices = Vec::new();
        let mut seen = HashSet::new();
        let k = k as usize;

        for i in 0..nums.len() {
            if seen.contains(&i) {
                continue;
            }

            let mut found = false;
            for j in 0..s.len() {
                if nums[i] == s.chars().nth(j).unwrap() as i32 {
                    if j >= k || j + k < s.len() {
                        found = true;
                        break;
                    }
                }
            }

            if found {
                indices.push(i as i32);
                seen.insert(i);
            }
        }

        indices
    }
}
}