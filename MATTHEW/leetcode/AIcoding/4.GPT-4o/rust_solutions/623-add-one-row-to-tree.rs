use std::rc::Rc;
use std::cell::RefCell;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn add_one_row(root: Option<Box<TreeNode>>, v: i32, d: i32) -> Option<Box<TreeNode>> {
    if d == 1 {
        let new_root = Some(Box::new(TreeNode::new(v)));
        new_root.as_ref().unwrap().left = Some(root);
        return new_root;
    }
    fn dfs(node: &mut Option<Box<TreeNode>>, v: i32, d: i32, current_depth: i32) {
        if let Some(n) = node {
            if current_depth == d - 1 {
                let left = n.left.take();
                let right = n.right.take();
                n.left = Some(Box::new(TreeNode::new(v)));
                n.left.as_mut().unwrap().left = left;
                n.right = Some(Box::new(TreeNode::new(v)));
                n.right.as_mut().unwrap().right = right;
            } else {
                dfs(&mut n.left, v, d, current_depth + 1);
                dfs(&mut n.right, v, d, current_depth + 1);
            }
        }
    }
    let mut root = root;
    dfs(&mut root, v, d, 1);
    root
}