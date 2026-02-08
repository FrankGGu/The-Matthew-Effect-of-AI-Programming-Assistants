use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sorted_list_to_bst(head: Option<Box<ListNode>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nums = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            nums.push(node.val);
            current = node.next;
        }
        Self::build_bst(&nums)
    }

    fn build_bst(nums: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nums.is_empty() {
            return None;
        }
        let mid = nums.len() / 2;
        let mut node = TreeNode::new(nums[mid]);
        node.left = Self::build_bst(&nums[..mid]);
        node.right = Self::build_bst(&nums[mid + 1..]);
        Some(Rc::new(RefCell::new(node)))
    }
}