use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sorted_array_to_bst(nums: Vec<i32>) -> Option<Rc<RefCell<TreeNode>>> {
        fn helper(nums: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
            if nums.is_empty() {
                return None;
            }
            let mid = nums.len() / 2;
            let mut node = TreeNode::new(nums[mid]);
            node.left = helper(&nums[..mid]);
            node.right = helper(&nums[mid + 1..]);
            Some(Rc::new(RefCell::new(node)))
        }
        helper(&nums)
    }
}