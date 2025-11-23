use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut nums = Vec::new();
        Self::inorder(root, &mut nums);

        let mut left = 0;
        let mut right = nums.len() - 1;

        while left < right {
            let sum = nums[left] + nums[right];
            if sum == k {
                return true;
            } else if sum < k {
                left += 1;
            } else {
                right -= 1;
            }
        }

        false
    }

    fn inorder(root: Option<Rc<RefCell<TreeNode>>>, nums: &mut Vec<i32>) {
        if let Some(node) = root {
            Self::inorder(node.borrow().left.clone(), nums);
            nums.push(node.borrow().val);
            Self::inorder(node.borrow().right.clone(), nums);
        }
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