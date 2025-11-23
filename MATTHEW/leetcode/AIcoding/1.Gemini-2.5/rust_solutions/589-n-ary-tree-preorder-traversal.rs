use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn preorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::traverse_preorder(root, &mut result);
        result
    }

    fn traverse_preorder(node_opt: Option<Rc<RefCell<Node>>>, result: &mut Vec<i32>) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            result.push(node.val);
            for child_opt in node.children.iter() {
                Self::traverse_preorder(child_opt.clone(), result);
            }
        }
    }
}