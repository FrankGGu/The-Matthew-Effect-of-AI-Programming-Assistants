use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn find_frequent_tree_sum(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut freq_map = HashMap::new();
        let mut max_freq = 0;

        Self::dfs(&root, &mut freq_map, &mut max_freq);

        freq_map.into_iter()
            .filter(|&(_, freq)| freq == max_freq)
            .map(|(sum, _)| sum)
            .collect()
    }

    fn dfs(root: &Option<Rc<RefCell<TreeNode>>>, freq_map: &mut HashMap<i32, i32>, max_freq: &mut i32) -> i32 {
        match root {
            Some(node) => {
                let node_ref = node.borrow();
                let left_sum = Self::dfs(&node_ref.left, freq_map, max_freq);
                let right_sum = Self::dfs(&node_ref.right, freq_map, max_freq);
                let sum = node_ref.val + left_sum + right_sum;

                let entry = freq_map.entry(sum).or_insert(0);
                *entry += 1;
                *max_freq = (*max_freq).max(*entry);

                sum
            },
            None => 0,
        }
    }
}