use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{BTreeMap, VecDeque};

impl Solution {
    pub fn vertical_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        if root.is_none() {
            return vec![];
        }

        let mut map: BTreeMap<i32, BTreeMap<i32, Vec<i32>>> = BTreeMap::new();
        let mut queue = VecDeque::new();
        queue.push_back((root.unwrap(), 0, 0));

        while let Some((node, col, row)) = queue.pop_front() {
            let node = node.borrow();
            map.entry(col)
                .or_default()
                .entry(row)
                .or_default()
                .push(node.val);

            if let Some(left) = node.left.clone() {
                queue.push_back((left, col - 1, row + 1));
            }
            if let Some(right) = node.right.clone() {
                queue.push_back((right, col + 1, row + 1));
            }
        }

        let mut result = Vec::new();
        for cols in map.values() {
            let mut col_vec = Vec::new();
            for rows in cols.values() {
                let mut sorted_rows = rows.clone();
                sorted_rows.sort();
                col_vec.extend(sorted_rows);
            }
            result.push(col_vec);
        }

        result
    }
}