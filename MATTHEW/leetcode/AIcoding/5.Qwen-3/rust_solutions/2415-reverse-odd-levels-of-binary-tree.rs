impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn reverse_odd_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, level: i32, nodes: &mut Vec<Option<Rc<RefCell<TreeNode>>>>) {
        if let Some(n) = node {
            if level % 2 == 1 {
                nodes.push(Some(n.clone()));
            }
            dfs(n.borrow().left.clone(), level + 1, nodes);
            dfs(n.borrow().right.clone(), level + 1, nodes);
        }
    }

    fn reverse_nodes(nodes: &mut Vec<Option<Rc<RefCell<TreeNode>>>>) {
        let len = nodes.len();
        for i in 0..len / 2 {
            let j = len - 1 - i;
            if let (Some(n1), Some(n2)) = (nodes[i].as_ref(), nodes[j].as_ref()) {
                std::mem::swap(&mut n1.borrow_mut().val, &mut n2.borrow_mut().val);
            }
        }
    }

    let mut nodes = Vec::new();
    dfs(root.clone(), 0, &mut nodes);
    reverse_nodes(&mut nodes);
    root
}
}