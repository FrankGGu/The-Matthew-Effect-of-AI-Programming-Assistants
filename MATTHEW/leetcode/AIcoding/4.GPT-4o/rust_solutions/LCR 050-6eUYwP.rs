use std::rc::Rc;
use std::cell::RefCell;

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

pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, sum: i32) -> i32 {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, sum: i32) -> i32 {
        if let Some(n) = node {
            let val = n.borrow().val;
            let mut count = 0;
            if val == sum {
                count += 1;
            }
            count += dfs(n.borrow().left.as_ref(), sum - val);
            count += dfs(n.borrow().right.as_ref(), sum - val);
            count
        } else {
            0
        }
    }

    fn helper(node: Option<&Rc<RefCell<TreeNode>>>, sum: i32) -> i32 {
        if node.is_none() {
            return 0;
        }
        let count = dfs(node, sum);
        count + helper(node.unwrap().borrow().left.as_ref(), sum) + helper(node.unwrap().borrow().right.as_ref(), sum)
    }

    helper(root.as_ref(), sum)
}