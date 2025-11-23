impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        fn dfs(nums: &Vec<i32>, start: usize, target: i32, memo: &mut HashMap<(usize, i32), i32>) -> i32 {
            if start >= nums.len() - 1 {
                return 0;
            }
            if let Some(&res) = memo.get(&(start, target)) {
                return res;
            }
            let mut max_ops = 0;
            for i in start + 1..nums.len() {
                if nums[start] + nums[i] == target {
                    max_ops = max_ops.max(1 + dfs(nums, i, target, memo));
                }
            }
            memo.insert((start, target), max_ops);
            max_ops
        }

        let n = nums.len();
        let mut max_ops = 0;
        for i in 1..n {
            let target = nums[0] + nums[i];
            let mut memo = HashMap::new();
            max_ops = max_ops.max(1 + dfs(&nums, i, target, &mut memo));
        }
        max_ops
    }
}
}