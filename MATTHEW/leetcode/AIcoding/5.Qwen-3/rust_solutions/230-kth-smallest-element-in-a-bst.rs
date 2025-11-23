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

pub fn kth_smallest(root: Option<Box<TreeNode>>, k: i32) -> i32 {
    let mut stack = Vec::new();
    let mut current = root;
    let mut count = 0;

    while let Some(node) = current {
        stack.push(node);
        current = node.left;
    }

    while let Some(mut node) = stack.pop() {
        count += 1;
        if count == k {
            return node.val;
        }
        current = node.right;
        while let Some(child) = current {
            stack.push(child);
            current = child.left;
        }
    }

    unreachable!()
}
}