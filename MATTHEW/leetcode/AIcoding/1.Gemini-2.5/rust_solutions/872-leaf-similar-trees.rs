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
    pub fn is_leaf_similar(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let mut seq1 = Vec::new();
        let mut seq2 = Vec::new();

        fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, sequence: &mut Vec<i32>) {
            if let Some(node_rc) = node_opt {
                let node = node_rc.borrow();
                if node.left.is_none() && node.right.is_none() {
                    sequence.push(node.val);
                } else {
                    dfs(node.left.clone(), sequence);
                    dfs(node.right.clone(), sequence);
                }
            }
        }

        dfs(root1, &mut seq1);
        dfs(root2, &mut seq2);

        seq1 == seq2
    }
}