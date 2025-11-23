use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn kth_smallest(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        let mut stack = Vec::new();
        let mut current = root;
        let mut k = k;

        loop {
            while let Some(node) = current {
                stack.push(node.clone());
                current = node.borrow().left.clone();
            }

            if let Some(node) = stack.pop() {
                k -= 1;
                if k == 0 {
                    return node.borrow().val;
                }
                current = node.borrow().right.clone();
            } else {
                break;
            }
        }

        -1
    }
}