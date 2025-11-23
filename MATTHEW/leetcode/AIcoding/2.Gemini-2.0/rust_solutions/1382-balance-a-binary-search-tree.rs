#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn balance_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut inorder = Vec::new();
        fn inorder_traversal(node: Option<Rc<RefCell<TreeNode>>>, inorder: &mut Vec<i32>) {
            if let Some(node_rc) = node {
                let node = node_rc.borrow();
                inorder_traversal(node.left.clone(), inorder);
                inorder.push(node.val);
                inorder_traversal(node.right.clone(), inorder);
            }
        }

        inorder_traversal(root, &mut inorder);

        fn build_bst(inorder: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
            if inorder.is_empty() {
                return None;
            }

            let mid = inorder.len() / 2;
            let root = Rc::new(RefCell::new(TreeNode::new(inorder[mid])));

            let left_subtree = build_bst(&inorder[..mid]);
            let right_subtree = build_bst(&inorder[mid + 1..]);

            root.borrow_mut().left = left_subtree;
            root.borrow_mut().right = right_subtree;

            Some(root)
        }

        build_bst(&inorder)
    }
}

struct Solution;