use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn postorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::traverse_postorder(root, &mut result);
        result
    }

    fn traverse_postorder(node_opt: Option<Rc<RefCell<Node>>>, result: &mut Vec<i32>) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            for child_opt in &node.children {
                Self::traverse_postorder(child_opt.clone(), result);
            }
            result.push(node.val);
        }
    }
}