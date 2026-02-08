use std::cell::RefCell;
use std::collections::{HashMap, VecDeque};
use std::rc::Rc;

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

impl Solution {
    pub fn vertical_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut map: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        let mut queue: VecDeque<(Rc<RefCell<TreeNode>>, i32, i32)> = VecDeque::new();

        if let Some(node) = root {
            queue.push_back((node, 0, 0));
        }

        while let Some((node, col, row)) = queue.pop_front() {
            let mut node_ref = node.borrow_mut();
            map.entry(col)
                .or_insert(Vec::new())
                .push((row, node_ref.val));

            if let Some(left) = node_ref.left.take() {
                queue.push_back((left, col - 1, row + 1));
                node_ref.left = Some(left);
            }
            if let Some(right) = node_ref.right.take() {
                queue.push_back((right, col + 1, row + 1));
                node_ref.right = Some(right);
            }
        }

        let mut keys: Vec<i32> = map.keys().cloned().collect();
        keys.sort();

        let mut result: Vec<Vec<i32>> = Vec::new();
        for key in keys {
            let mut values = map.get_mut(&key).unwrap();
            values.sort_by(|a, b| {
                if a.0 == b.0 {
                    a.1.cmp(&b.1)
                } else {
                    a.0.cmp(&b.0)
                }
            });

            let mut col_values: Vec<i32> = Vec::new();
            for value in values {
                col_values.push(value.1);
            }
            result.push(col_values);
        }

        result
    }
}

struct Solution;