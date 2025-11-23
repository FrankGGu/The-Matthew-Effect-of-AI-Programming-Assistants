impl Solution {

use std::collections::{HashMap, VecDeque};

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

pub fn getCoprimesOfBinaryTree(root: Option<Box<TreeNode>>) -> Vec<i32> {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            gcd(b, a % b)
        }
    }

    let mut result = vec![];
    let mut depth_map = HashMap::new();
    let mut path = vec![];
    let mut values = vec![];

    fn dfs(
        node: &Option<Box<TreeNode>>,
        depth: i32,
        path: &mut Vec<i32>,
        values: &mut Vec<i32>,
        depth_map: &mut HashMap<i32, Vec<i32>>,
        result: &mut Vec<i32>,
    ) {
        if let Some(n) = node {
            let val = n.val;
            path.push(val);
            values.push(val);

            let mut max_depth = -1;
            let mut max_val = -1;

            for (d, vs) in depth_map.iter() {
                for v in vs {
                    if gcd(*v, val) == 1 {
                        if *d > max_depth {
                            max_depth = *d;
                            max_val = *v;
                        }
                    }
                }
            }

            result.push(max_val);

            depth_map.entry(depth).or_insert_with(Vec::new).push(val);

            dfs(&n.left, depth + 1, path, values, depth_map, result);
            dfs(&n.right, depth + 1, path, values, depth_map, result);

            depth_map.get_mut(&depth).unwrap().pop();
            path.pop();
            values.pop();
        }
    }

    dfs(&root, 0, &mut vec![], &mut vec![], &mut depth_map, &mut result);
    result
}
}