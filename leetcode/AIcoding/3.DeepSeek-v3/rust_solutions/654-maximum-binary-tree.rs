use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn construct_maximum_binary_tree(nums: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::build_tree(&nums)
    }

    fn build_tree(nums: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nums.is_empty() {
            return None;
        }

        let max_idx = nums.iter().enumerate().max_by_key(|(_, &val)| val).unwrap().0;
        let mut node = TreeNode::new(nums[max_idx]);
        node.left = Self::build_tree(&nums[..max_idx]);
        node.right = Self::build_tree(&nums[max_idx + 1..]);

        Some(Rc::new(RefCell::new(node)))
    }
}