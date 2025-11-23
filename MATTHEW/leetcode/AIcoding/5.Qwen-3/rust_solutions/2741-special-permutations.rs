impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn special_permutations(nums: Vec<i32>) -> i32 {
        fn dfs(
            nums: &Vec<i32>,
            used: &mut Vec<bool>,
            prev: i32,
            memo: &mut HashMap<(i32, usize), i32>,
        ) -> i32 {
            let mut res = 0;
            let key = (prev, used.iter().map(|b| if *b { 1 } else { 0 }).collect::<Vec<_>>().iter().rev().map(|b| *b).collect::<Vec<_>>().into_iter().fold(0, |acc, b| acc * 2 + b));
            if let Some(&v) = memo.get(&key) {
                return v;
            }
            for i in 0..nums.len() {
                if !used[i] && (prev == -1 || nums[i] % nums[prev as usize] == 0 || nums[prev as usize] % nums[i] == 0) {
                    used[i] = true;
                    res += dfs(nums, used, i as i32, memo);
                    used[i] = false;
                }
            }
            memo.insert(key, res);
            res
        }

        let n = nums.len();
        let mut memo = HashMap::new();
        let mut used = vec![false; n];
        dfs(&nums, &mut used, -1, &mut memo)
    }
}
}