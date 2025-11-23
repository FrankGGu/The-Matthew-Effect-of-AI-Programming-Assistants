impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

type Node = Rc<RefCell<TreeNode>>;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Node>,
    pub right: Option<Node>,
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

pub fn tree_to_dll(mut root: Option<Node>) -> Option<Node> {
    let mut prev: Option<Node> = None;
    let mut head: Option<Node> = None;

    fn inorder(node: Option<Node>, prev: &mut Option<Node>, head: &mut Option<Node>) {
        if let Some(n) = node {
            inorder(n.borrow().left.clone(), prev, head);
            if let Some(p) = prev {
                p.borrow_mut().right = Some(n.clone());
                n.borrow_mut().left = Some(p);
            } else {
                *head = Some(n.clone());
            }
            *prev = Some(n);
            inorder(n.borrow().right.clone(), prev, head);
        }
    }

    inorder(root.clone(), &mut prev, &mut head);
    head
}
}