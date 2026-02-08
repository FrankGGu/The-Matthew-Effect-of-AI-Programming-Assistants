use std::rc::Rc;
use std::cell::RefCell;

type NodeRef = Rc<RefCell<Node>>;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<NodeRef>,
    pub right: Option<NodeRef>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn tree_to_doubly_list(root: Option<NodeRef>) -> Option<NodeRef> {
        if root.is_none() {
            return None;
        }
        let mut prev: Option<NodeRef> = None;
        let mut head: Option<NodeRef> = None;
        Self::inorder_traverse(root, &mut prev, &mut head);
        if let Some(head) = head.as_ref() {
            if let Some(prev) = prev.as_ref() {
                let mut head_borrow = head.borrow_mut();
                let mut prev_borrow = prev.borrow_mut();
                head_borrow.left = Some(prev.clone());
                prev_borrow.right = Some(head.clone());
            }
        }
        head
    }

    fn inorder_traverse(node: Option<NodeRef>, prev: &mut Option<NodeRef>, head: &mut Option<NodeRef>) {
        if let Some(n) = node {
            let n_ref = n.borrow();
            Self::inorder_traverse(n_ref.left.clone(), prev, head);
            if head.is_none() {
                *head = Some(n.clone());
            }
            if let Some(p) = prev {
                let mut p_borrow = p.borrow_mut();
                let mut n_borrow = n.borrow_mut();
                p_borrow.right = Some(n.clone());
                n_borrow.left = Some(p.clone());
            }
            *prev = Some(n.clone());
            Self::inorder_traverse(n_ref.right.clone(), prev, head);
        }
    }
}