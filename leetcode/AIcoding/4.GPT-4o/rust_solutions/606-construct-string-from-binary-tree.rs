use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn tree2str(root: Option<Rc<RefCell<TreeNode>>>) -> String {
    if let Some(node) = root {
        let node = node.borrow();
        let mut result = node.val.to_string();
        if node.left.is_some() {
            result.push('(');
            result.push_str(&tree2str(node.left.clone()));
            result.push(')');
        } else if node.right.is_some() {
            result.push("()".to_string());
        }
        if node.right.is_some() {
            result.push('(');
            result.push_str(&tree2str(node.right.clone()));
            result.push(')');
        }
        result
    } else {
        String::new()
    }
}