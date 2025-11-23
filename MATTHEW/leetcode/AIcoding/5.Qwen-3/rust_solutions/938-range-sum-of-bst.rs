impl Solution {

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

pub struct Solution {}

impl Solution {
    pub fn range_sum_bst(root: Option<Box<TreeNode>>, low: i32, high: i32) -> i32 {
        if let Some(node) = root {
            let mut sum = 0;
            if node.val > low {
                sum += Self::range_sum_bst(node.left, low, high);
            }
            if node.val < high {
                sum += Self::range_sum_bst(node.right, low, high);
            }
            if node.val >= low && node.val <= high {
                sum += node.val;
            }
            sum
        } else {
            0
        }
    }
}
}