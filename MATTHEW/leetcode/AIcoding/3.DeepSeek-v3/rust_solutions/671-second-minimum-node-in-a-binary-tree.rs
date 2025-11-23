use std::rc::Rc;
use std::cell::RefCell;
use std::collections::BTreeSet;

impl Solution {
    pub fn find_second_minimum_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut values = BTreeSet::new();
        Self::traverse(root, &mut values);
        if values.len() < 2 {
            -1
        } else {
            *values.iter().nth(1).unwrap()
        }
    }

    fn traverse(node: Option<Rc<RefCell<TreeNode>>>, values: &mut BTreeSet<i32>) {
        if let Some(node) = node {
            let node = node.borrow();
            values.insert(node.val);
            Self::traverse(node.left.clone(), values);
            Self::traverse(node.right.clone(), values);
        }
    }
}