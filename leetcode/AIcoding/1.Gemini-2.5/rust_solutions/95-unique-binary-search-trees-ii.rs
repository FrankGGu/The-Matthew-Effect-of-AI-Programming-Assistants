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

struct Solution;

impl Solution {
    pub fn generate_trees(n: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        if n == 0 {
            return vec![];
        }
        Self::generate_trees_recursive(1, n)
    }

    fn generate_trees_recursive(start: i32, end: i32) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut all_trees = Vec::new();

        if start > end {
            all_trees.push(None);
            return all_trees;
        }

        for i in start..=end {
            let left_subtrees = Self::generate_trees_recursive(start, i - 1);
            let right_subtrees = Self::generate_trees_recursive(i + 1, end);

            for left_tree in &left_subtrees {
                for right_tree in &right_subtrees {
                    let mut root = TreeNode::new(i);
                    root.left = left_tree.clone();
                    root.right = right_tree.clone();
                    all_trees.push(Some(Rc::new(RefCell::new(root))));
                }
            }
        }
        all_trees
    }
}