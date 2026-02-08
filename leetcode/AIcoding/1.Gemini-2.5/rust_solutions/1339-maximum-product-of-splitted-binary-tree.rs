use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_product(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut all_subtree_sums: Vec<i64> = Vec::new();
        let total_sum = Self::calculate_sums(&root, &mut all_subtree_sums);

        let mut max_prod: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for &s in &all_subtree_sums {
            let current_prod = s * (total_sum - s);
            if current_prod > max_prod {
                max_prod = current_prod;
            }
        }

        (max_prod % modulo) as i32
    }

    fn calculate_sums(node: &Option<Rc<RefCell<TreeNode>>>, all_subtree_sums: &mut Vec<i64>) -> i64 {
        match node {
            None => 0,
            Some(rc_node) => {
                let node_borrow = rc_node.borrow();

                let left_sum = Self::calculate_sums(&node_borrow.left, all_subtree_sums);
                let right_sum = Self::calculate_sums(&node_borrow.right, all_subtree_sums);

                let current_node_sum = node_borrow.val as i64 + left_sum + right_sum;
                all_subtree_sums.push(current_node_sum);
                current_node_sum
            }
        }
    }
}