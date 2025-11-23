use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>, target_sum: i64, current: &mut Vec<i64>) -> i32 {
            if let Some(n) = node {
                let n = n.borrow();
                let val = n.val as i64;
                let mut count = 0;
                current.push(0);
                for i in 0..current.len() {
                    current[i] += val;
                    if current[i] == target_sum {
                        count += 1;
                    }
                }
                count += helper(&n.left, target_sum, current);
                count += helper(&n.right, target_sum, current);
                for i in 0..current.len() {
                    current[i] -= val;
                }
                current.pop();
                count
            } else {
                0
            }
        }
        helper(&root, target_sum as i64, &mut Vec::new())
    }
}