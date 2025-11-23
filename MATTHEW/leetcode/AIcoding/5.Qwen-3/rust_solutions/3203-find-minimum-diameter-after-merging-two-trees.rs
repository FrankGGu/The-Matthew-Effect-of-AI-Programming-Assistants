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

pub fn min_diameter_after_merging(t1: Option<Box<TreeNode>>, t2: Option<Box<TreeNode>>) -> i32 {
    fn get_height_and_diameter(node: Option<Box<TreeNode>>, map: &mut HashMap<i32, i32>) -> (i32, i32) {
        if let Some(n) = node {
            let (left_h, left_d) = get_height_and_diameter(n.left, map);
            let (right_h, right_d) = get_height_and_diameter(n.right, map);
            let height = 1 + std::cmp::max(left_h, right_h);
            let diameter = std::cmp::max(left_d, right_d);
            let current_d = left_h + right_h + 1;
            let max_d = std::cmp::max(diameter, current_d);
            map.insert(n.val, height);
            (height, max_d)
        } else {
            (0, 0)
        }
    }

    let mut map1 = HashMap::new();
    let (_, d1) = get_height_and_diameter(t1, &mut map1);

    let mut map2 = HashMap::new();
    let (_, d2) = get_height_and_diameter(t2, &mut map2);

    let max_height1 = map1.values().max().copied().unwrap_or(0);
    let max_height2 = map2.values().max().copied().unwrap_or(0);

    std::cmp::min(d1, d2) + max_height1 + max_height2 - 1
}
}