use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn find_frequent_tree_sum(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut freq_map: HashMap<i32, i32> = HashMap::new();

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, freq_map: &mut HashMap<i32, i32>) -> i32 {
            if let Some(n_rc) = node {
                let n = n_rc.borrow();
                let left_sum = dfs(n.left.clone(), freq_map);
                let right_sum = dfs(n.right.clone(), freq_map);
                let current_sum = n.val + left_sum + right_sum;
                *freq_map.entry(current_sum).or_insert(0) += 1;
                current_sum
            } else {
                0
            }
        }

        dfs(root, &mut freq_map);

        if freq_map.is_empty() {
            return Vec::new();
        }

        let max_freq = *freq_map.values().max().unwrap();

        freq_map.into_iter()
            .filter(|&(_, count)| count == max_freq)
            .map(|(sum, _)| sum)
            .collect()
    }
}