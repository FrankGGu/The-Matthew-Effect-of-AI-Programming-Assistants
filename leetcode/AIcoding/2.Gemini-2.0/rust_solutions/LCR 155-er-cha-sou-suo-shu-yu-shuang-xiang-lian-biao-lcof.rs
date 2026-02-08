use std::cell::RefCell;
use std::rc::Rc;

type TreeNode = Option<Rc<RefCell<Node>>>;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Rc<RefCell<Node>>>,
    pub right: Option<Rc<RefCell<Node>>>,
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

impl Solution {
    pub fn tree_to_doubly_list(root: TreeNode) -> TreeNode {
        if root.is_none() {
            return None;
        }

        let mut head: TreeNode = None;
        let mut prev: TreeNode = None;

        fn inorder(node: TreeNode, head: &mut TreeNode, prev: &mut TreeNode) {
            if let Some(n) = node {
                let left = n.borrow().left.clone();
                let right = n.borrow().right.clone();

                inorder(left, head, prev);

                if prev.is_none() {
                    *head = Some(n.clone());
                } else {
                    if let Some(p) = prev {
                        p.borrow_mut().right = Some(n.clone());
                        n.borrow_mut().left = Some(p.clone());
                    }
                }

                *prev = Some(n.clone());

                inorder(right, head, prev);
            }
        }

        inorder(root, &mut head, &mut prev);

        if let Some(h) = &head {
            if let Some(p) = &prev {
                h.borrow_mut().left = Some(p.clone());
                p.borrow_mut().right = Some(h.clone());
            }
        }

        head
    }
}

struct Solution;