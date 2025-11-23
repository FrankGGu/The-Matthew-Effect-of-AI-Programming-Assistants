use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn del_nodes(
        root: Option<Rc<RefCell<TreeNode>>>,
        to_delete: Vec<i32>,
    ) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let to_delete_set: std::collections::HashSet<i32> = to_delete.into_iter().collect();
        let mut result: Vec<Option<Rc<RefCell<TreeNode>>>> = Vec::new();

        fn dfs(
            node: Option<Rc<RefCell<TreeNode>>>,
            to_delete_set: &std::collections::HashSet<i32>,
            result: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
            is_root: bool,
        ) -> Option<Rc<RefCell<TreeNode>>> {
            if node.is_none() {
                return None;
            }

            let current_node = node.unwrap();
            let val = current_node.borrow().val;

            let left = current_node.borrow().left.clone();
            let right = current_node.borrow().right.clone();

            let left_subtree = dfs(left, to_delete_set, result, to_delete_set.contains(&val));
            let right_subtree = dfs(right, to_delete_set, result, to_delete_set.contains(&val));

            current_node.borrow_mut().left = left_subtree;
            current_node.borrow_mut().right = right_subtree;

            if to_delete_set.contains(&val) {
                if current_node.borrow().left.is_some() {
                    result.push(current_node.borrow().left.clone());
                }
                if current_node.borrow().right.is_some() {
                    result.push(current_node.borrow().right.clone());
                }
                None
            } else {
                if is_root {
                    result.push(Some(current_node.clone()));
                }
                Some(current_node)
            }
        }

        dfs(root, &to_delete_set, &mut result, true);
        result
    }
}