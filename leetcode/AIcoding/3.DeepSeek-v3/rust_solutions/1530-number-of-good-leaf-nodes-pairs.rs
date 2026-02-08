use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn count_pairs(root: Option<Rc<RefCell<TreeNode>>>, distance: i32) -> i32 {
        let mut res = 0;
        Self::dfs(&root, distance, &mut res);
        res
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, distance: i32, res: &mut i32) -> Vec<i32> {
        if node.is_none() {
            return vec![];
        }
        let node = node.as_ref().unwrap().borrow();
        if node.left.is_none() && node.right.is_none() {
            return vec![0];
        }
        let left = Self::dfs(&node.left, distance, res);
        let right = Self::dfs(&node.right, distance, res);
        for &l in &left {
            for &r in &right {
                if l + r + 2 <= distance {
                    *res += 1;
                }
            }
        }
        let mut ret = vec![];
        for &l in &left {
            if l + 1 < distance {
                ret.push(l + 1);
            }
        }
        for &r in &right {
            if r + 1 < distance {
                ret.push(r + 1);
            }
        }
        ret
    }
}