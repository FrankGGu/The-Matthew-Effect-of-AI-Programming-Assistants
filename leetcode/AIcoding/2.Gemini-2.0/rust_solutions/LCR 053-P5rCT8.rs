use std::rc::Rc;
use std::cell::RefCell;

type TreeNode = Option<Rc<RefCell<TreeNodeStruct>>>;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNodeStruct {
  pub val: i32,
  pub left: TreeNode,
  pub right: TreeNode,
}

impl TreeNodeStruct {
  #[inline]
  pub fn new(val: i32) -> Self {
    TreeNodeStruct {
      val,
      left: None,
      right: None
    }
  }
}

impl Solution {
    pub fn inorder_successor(root: TreeNode, p: TreeNode) -> TreeNode {
        let mut successor: TreeNode = None;
        let mut current = root;

        while let Some(node) = current {
            let node_ref = node.borrow();
            if node_ref.val > p.as_ref().unwrap().borrow().val {
                successor = Some(Rc::clone(&node));
                current = node_ref.left.clone();
            } else {
                current = node_ref.right.clone();
            }
        }

        successor
    }
}

struct Solution;