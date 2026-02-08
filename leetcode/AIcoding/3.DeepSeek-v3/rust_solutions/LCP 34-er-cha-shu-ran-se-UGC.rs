use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_value(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, k: i32) -> Vec<i32> {
            if node.is_none() {
                return vec![0; (k + 1) as usize];
            }
            let node = node.unwrap();
            let node_ref = node.borrow();
            let left = dfs(node_ref.left.clone(), k);
            let right = dfs(node_ref.right.clone(), k);
            let mut res = vec![0; (k + 1) as usize];
            for i in 0..=k as usize {
                if i == 0 {
                    res[i] = left[k as usize] + right[k as usize];
                } else {
                    let mut max_val = 0;
                    for l in 0..=i - 1 {
                        let r = i - 1 - l;
                        max_val = max_val.max(left[l] + right[r]);
                    }
                    res[i] = max_val + node_ref.val;
                }
            }
            for i in (0..k as usize).rev() {
                res[i] = res[i].max(res[i + 1]);
            }
            res
        }
        let res = dfs(root, k);
        res[0]
    }
}