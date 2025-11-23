impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn num_factored_binary_trees(n: i32, mut nums: Vec<i32>) -> i32 {
    nums.sort_unstable();
    let mut map = HashMap::new();
    for (i, &num) in nums.iter().enumerate() {
        map.insert(num, i);
    }

    let mut dp = vec![1; nums.len()];
    for i in 0..nums.len() {
        for j in 0..i {
            if nums[i] % nums[j] == 0 {
                let target = nums[i] / nums[j];
                if let Some(k) = map.get(&target) {
                    dp[i] += dp[j] * dp[*k];
                }
            }
        }
    }

    dp.iter().sum()
}
}