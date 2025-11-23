use std::cell::RefCell;
use std::rc::Rc;

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

struct Solution {
    total_sum: i64,
    max_product: i64,
}

impl Solution {
    pub fn max_product_split_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut solution = Solution {
            total_sum: 0,
            max_product: 0,
        };
        solution.total_sum = solution.compute_sum(&root);
        solution.compute_max_product(&root);
        (solution.max_product % 1_000_000_007) as i32
    }

    fn compute_sum(&mut self, node: &Option<Rc<RefCell<TreeNode>>>) -> i64 {
        if let Some(n) = node {
            let n = n.borrow();
            self.compute_sum(&n.left) + self.compute_sum(&n.right) + n.val as i64
        } else {
            0
        }
    }

    fn compute_max_product(&mut self, node: &Option<Rc<RefCell<TreeNode>>>) -> i64 {
        if let Some(n) = node {
            let n = n.borrow();
            let left_sum = self.compute_max_product(&n.left);
            let right_sum = self.compute_max_product(&n.right);
            let current_sum = left_sum + right_sum + n.val as i64;
            let product = current_sum * (self.total_sum - current_sum);
            self.max_product = self.max_product.max(product);
            current_sum
        } else {
            0
        }
    }
}