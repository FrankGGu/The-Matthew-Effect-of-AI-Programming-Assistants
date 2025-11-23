use std::rc::Rc;
use std::cell::RefCell;

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
      right: None
    }
  }
}

impl Solution {
    pub fn construct_from_prepost(preorder: Vec<i32>, postorder: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::build(&preorder, &postorder)
    }

    fn build(pre: &[i32], post: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if pre.is_empty() {
            return None;
        }

        let root_val = pre[0];
        let mut root_node = TreeNode::new(root_val);

        if pre.len() == 1 {
            return Some(Rc::new(RefCell::new(root_node)));
        }

        // The root of the left subtree is pre[1].
        // We find this value in the postorder traversal to determine the size of the left subtree.
        let left_root_val = pre[1];
        let mut left_subtree_size = 0; // Number of nodes in the left subtree
        for (i, &val) in post.iter().enumerate() {
            if val == left_root_val {
                // If post[i] is the left_root_val, then post[0..=i] is the postorder traversal
                // of the left subtree. The number of nodes is i + 1.
                left_subtree_size = i + 1;
                break;
            }
        }

        // Recursively build the left subtree
        // Preorder for left: pre[1 .. 1 + left_subtree_size]
        // Postorder for left: post[0 .. left_subtree_size]
        root_node.left = Self::build(
            &pre[1 .. 1 + left_subtree_size],
            &post[0 .. left_subtree_size]
        );

        // Recursively build the right subtree
        // Preorder for right: pre[1 + left_subtree_size .. pre.len()]
        // Postorder for right: post[left_subtree_size .. post.len() - 1] (excluding the current root)
        root_node.right = Self::build(
            &pre[1 + left_subtree_size ..],
            &post[left_subtree_size .. post.len() - 1]
        );

        Some(Rc::new(RefCell::new(root_node)))
    }
}