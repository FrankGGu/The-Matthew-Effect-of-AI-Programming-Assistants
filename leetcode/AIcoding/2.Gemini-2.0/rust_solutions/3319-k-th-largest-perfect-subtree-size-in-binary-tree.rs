use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn kth_largest_perfect_subtree_size(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        let mut sizes: Vec<i32> = Vec::new();
        Self::dfs(root, &mut sizes);
        sizes.sort_unstable_by(|a, b| b.cmp(a));
        if sizes.len() < k as usize {
            return -1;
        }
        sizes[k as usize - 1]
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, sizes: &mut Vec<i32>) -> i32 {
        if let Some(n) = node {
            let left_size = Self::dfs(n.borrow().left.clone(), sizes);
            let right_size = Self::dfs(n.borrow().right.clone(), sizes);

            if left_size == right_size && (left_size == 0 || ((left_size & (left_size - 1)) == 0)) {
                let size = left_size + right_size + 1;
                sizes.push(size);
                return size;
            }
            return 0;
        }
        0
    }
}

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