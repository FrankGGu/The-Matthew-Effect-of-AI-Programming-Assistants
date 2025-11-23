use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut visited_nums: HashSet<i32> = HashSet::new();
        Self::dfs(root, k, &mut visited_nums)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, k: i32, visited_nums: &mut HashSet<i32>) -> bool {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            if visited_nums.contains(&(k - n.val)) {
                return true;
            }

            visited_nums.insert(n.val);

            if Self::dfs(n.left.clone(), k, visited_nums) {
                return true;
            }

            if Self::dfs(n.right.clone(), k, visited_nums) {
                return true;
            }
        }
        false
    }
}