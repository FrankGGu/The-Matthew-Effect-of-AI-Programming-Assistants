use std::cell::RefCell;
use std::rc::Rc;
use std::collections::HashMap;

impl Solution {
    pub fn find_mode(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        fn inorder(node: &Option<Rc<RefCell<TreeNode>>>, counts: &mut HashMap<i32, i32>>) {
            if let Some(n) = node {
                inorder(&n.borrow().left, counts);
                *counts.entry(n.borrow().val).or_insert(0) += 1;
                inorder(&n.borrow().right, counts);
            }
        }

        inorder(&root, &mut counts);

        let mut max_count = 0;
        for &count in counts.values() {
            max_count = std::cmp::max(max_count, count);
        }

        let mut result: Vec<i32> = Vec::new();
        for (&num, &count) in &counts {
            if count == max_count {
                result.push(num);
            }
        }

        result
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;