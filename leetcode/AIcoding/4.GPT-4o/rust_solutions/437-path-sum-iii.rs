use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, sum: i32) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, sum: i32, current_sum: i32) -> i32 {
            if let Some(n) = node {
                let n = n.borrow();
                let new_sum = current_sum + n.val;
                let mut count = 0;
                if new_sum == sum {
                    count += 1;
                }
                count += dfs(n.left.clone(), sum, new_sum);
                count += dfs(n.right.clone(), sum, new_sum);
                count
            } else {
                0
            }
        }

        fn helper(node: Option<Rc<RefCell<TreeNode>>>, sum: i32) -> i32 {
            if node.is_none() {
                return 0;
            }
            let count = dfs(node.clone(), sum, 0);
            count + helper(node.as_ref().unwrap().borrow().left.clone(), sum) + 
                   helper(node.as_ref().unwrap().borrow().right.clone(), sum)
        }

        helper(root, sum)
    }
}