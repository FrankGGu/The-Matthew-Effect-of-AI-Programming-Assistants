use std::collections::HashMap;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn count_palindrome_paths(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, count: &mut HashMap<i32, i32>, result: &mut i32) {
            if let Some(n) = node {
                count.insert(n.val, count.get(&n.val).unwrap_or(&0) + 1);
                if n.left.is_none() && n.right.is_none() {
                    let odd_count = count.values().filter(|&&v| v % 2 == 1).count();
                    if odd_count <= 1 {
                        *result += 1;
                    }
                } else {
                    dfs(&n.left, count, result);
                    dfs(&n.right, count, result);
                }
                count.insert(n.val, count[n.val] - 1);
                if count[n.val] == 0 {
                    count.remove(&n.val);
                }
            }
        }

        let mut count = HashMap::new();
        let mut result = 0;
        dfs(&root, &mut count, &mut result);
        result
    }
}