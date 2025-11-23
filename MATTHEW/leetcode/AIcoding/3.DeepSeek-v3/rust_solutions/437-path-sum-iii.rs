use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sums = std::collections::HashMap::new();
        prefix_sums.insert(0, 1);
        Self::dfs(root, target_sum, 0, &mut prefix_sums, &mut count);
        count
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        target_sum: i32,
        current_sum: i32,
        prefix_sums: &mut std::collections::HashMap<i32, i32>,
        count: &mut i32,
    ) {
        if let Some(n) = node {
            let n = n.borrow();
            let current_sum = current_sum + n.val;
            *count += prefix_sums.get(&(current_sum - target_sum)).unwrap_or(&0);
            *prefix_sums.entry(current_sum).or_insert(0) += 1;
            Self::dfs(n.left.clone(), target_sum, current_sum, prefix_sums, count);
            Self::dfs(n.right.clone(), target_sum, current_sum, prefix_sums, count);
            *prefix_sums.entry(current_sum).or_insert(0) -= 1;
        }
    }
}