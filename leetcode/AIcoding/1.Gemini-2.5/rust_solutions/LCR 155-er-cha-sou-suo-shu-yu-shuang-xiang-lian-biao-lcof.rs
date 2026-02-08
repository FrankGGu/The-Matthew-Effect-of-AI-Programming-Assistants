use std::rc::Rc;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn tree_to_doubly_list(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let head: Rc<RefCell<Option<Rc<RefCell<TreeNode>>>>> = Rc::new(RefCell::new(None));
        let prev: Rc<RefCell<Option<Rc<RefCell<TreeNode>>>>> = Rc::new(RefCell::new(None));

        Self::inorder_traverse(root, head.clone(), prev.clone());

        let first_node = head.borrow().as_ref().unwrap().clone();
        let last_node = prev.borrow().as_ref().unwrap().clone();

        first_node.borrow_mut().left = Some(last_node.clone());
        last_node.borrow_mut().right = Some(first_node.clone());

        Some(first_node)
    }

    fn inorder_traverse(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        head: Rc<RefCell<Option<Rc<RefCell<TreeNode>>>>>,
        prev: Rc<RefCell<Option<Rc<RefCell<TreeNode>>>>>,
    ) {
        if let Some(node) = node_opt {
            Self::inorder_traverse(node.borrow().left.clone(), head.clone(), prev.clone());

            if prev.borrow().is_none() {
                *head.borrow_mut() = Some(node.clone());
            } else {
                prev.borrow().as_ref().unwrap().borrow_mut().right = Some(node.clone());
                node.borrow_mut().left = Some(prev.borrow().as_ref().unwrap().clone());
            }
            *prev.borrow_mut() = Some(node.clone());

            Self::inorder_traverse(node.borrow().right.clone(), head.clone(), prev.clone());
        }
    }
}