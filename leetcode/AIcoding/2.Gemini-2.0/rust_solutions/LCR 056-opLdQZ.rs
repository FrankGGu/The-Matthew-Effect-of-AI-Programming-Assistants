use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut nums = vec![];
        fn inorder(node: &Option<Rc<RefCell<TreeNode>>>, nums: &mut Vec<i32>) {
            if let Some(n) = node {
                inorder(&n.borrow().left, nums);
                nums.push(n.borrow().val);
                inorder(&n.borrow().right, nums);
            }
        }
        inorder(&root, &mut nums);

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