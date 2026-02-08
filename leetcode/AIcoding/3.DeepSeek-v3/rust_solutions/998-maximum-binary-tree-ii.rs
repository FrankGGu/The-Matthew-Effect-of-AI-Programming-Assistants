use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn insert_into_max_tree(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            None => Some(Rc::new(RefCell::new(TreeNode::new(val))) ,
            Some(node) => {
                let mut node_ref = node.borrow_mut();
                if val > node_ref.val {
                    let new_node = TreeNode {
                        val,
                        left: Some(node.clone()),
                        right: None,
                    };
                    Some(Rc::new(RefCell::new(new_node)))
                } else {
                    let right = Self::insert_into_max_tree(node_ref.right.clone(), val);
                    node_ref.right = right;
                    Some(node.clone())
                }
            }
        }
    }
}