use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_product(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut sums = Vec::new();
        let total = Self::sum_tree(root.as_ref(), &mut sums);
        let mut max_product = 0;
        for &sum in &sums {
            max_product = max_product.max((sum as i64) * ((total - sum) as i64));
        }
        (max_product % (1_000_000_007)) as i32
    }

    fn sum_tree(root: Option<&Rc<RefCell<TreeNode>>>, sums: &mut Vec<i32>) -> i32 {
        if let Some(node) = root {
            let node = node.borrow();
            let left_sum = Self::sum_tree(node.left.as_ref(), sums);
            let right_sum = Self::sum_tree(node.right.as_ref(), sums);
            let total = node.val + left_sum + right_sum;
            sums.push(total);
            total
        } else {
            0
        }
    }
}