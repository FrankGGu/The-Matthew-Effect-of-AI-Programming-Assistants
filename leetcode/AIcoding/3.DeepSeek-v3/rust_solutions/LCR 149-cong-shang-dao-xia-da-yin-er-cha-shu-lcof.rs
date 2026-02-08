use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn decorate_record(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut res = Vec::new();
        if root.is_none() {
            return res;
        }
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root.unwrap());
        while !queue.is_empty() {
            let node = queue.pop_front().unwrap();
            let node = node.borrow();
            res.push(node.val);
            if let Some(left) = &node.left {
                queue.push_back(left.clone());
            }
            if let Some(right) = &node.right {
                queue.push_back(right.clone());
            }
        }
        res
    }
}