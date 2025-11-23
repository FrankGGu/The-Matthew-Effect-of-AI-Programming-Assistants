use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn print_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<String>> {
        fn get_height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                Some(n) => 1 + std::cmp::max(get_height(&n.borrow().left), get_height(&n.borrow().right)),
                None => 0,
            }
        }

        fn fill_result(
            node: &Option<Rc<RefCell<TreeNode>>>,
            result: &mut Vec<Vec<String>>,
            row: usize,
            left: usize,
            right: usize,
        ) {
            if let Some(n) = node {
                let mid = (left + right) / 2;
                result[row][mid] = n.borrow().val.to_string();
                fill_result(&n.borrow().left, result, row + 1, left, mid - 1);
                fill_result(&n.borrow().right, result, row + 1, mid + 1, right);
            }
        }

        if root.is_none() {
            return vec![];
        }

        let height = get_height(&root) as usize;
        let width = (1 << height) - 1;

        let mut result = vec![vec![String::from(""); width]; height];

        fill_result(&root, &mut result, 0, 0, width - 1);

        result
    }
}