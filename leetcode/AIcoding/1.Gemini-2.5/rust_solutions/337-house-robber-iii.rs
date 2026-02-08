use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn rob(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let res = Self::dfs(root);
        res[0].max(res[1])
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> [i32; 2] {
        match node {
            None => [0, 0],
            Some(node_rc) => {
                let node_ref = node_rc.borrow();
                let val = node_ref.val;

                let left_res = Self::dfs(node_ref.left.clone());
                let right_res = Self::dfs(node_ref.right.clone());

                let not_robbed_current = left_res[0].max(left_res[1]) + right_res[0].max(right_res[1]);
                let robbed_current = val + left_res[0] + right_res[0];

                [not_robbed_current, robbed_current]
            }
        }
    }
}