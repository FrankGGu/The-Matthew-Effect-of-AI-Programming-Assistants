use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

impl Solution {
    pub fn del_nodes(root: Option<Rc<RefCell<TreeNode>>>, to_delete: Vec<i32>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let to_delete_set: HashSet<i32> = to_delete.into_iter().collect();
        let mut forest = Vec::new();
        Self::helper(root, &to_delete_set, &mut forest, true);
        forest
    }

    fn helper(
        node: Option<Rc<RefCell<TreeNode>>>,
        to_delete_set: &HashSet<i32>,
        forest: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
        is_root: bool,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(n) = node {
            let mut node_ref = n.borrow_mut();
            let val = node_ref.val;
            let should_delete = to_delete_set.contains(&val);

            if !should_delete && is_root {
                forest.push(Some(n.clone()));
            }

            node_ref.left = Self::helper(node_ref.left.take(), to_delete_set, forest, should_delete);
            node_ref.right = Self::helper(node_ref.right.take(), to_delete_set, forest, should_delete);

            if should_delete {
                None
            } else {
                Some(n.clone())
            }
        } else {
            None
        }
    }
}