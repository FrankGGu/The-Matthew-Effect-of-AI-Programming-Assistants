use std::cell::RefCell;
use std::collections::HashMap;
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
    pub fn create_binary_tree(descriptions: Vec<Vec<i32>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes: HashMap<i32, Rc<RefCell<TreeNode>>> = HashMap::new();
        let mut children: HashMap<i32, bool> = HashMap::new();

        for desc in &descriptions {
            let parent_val = desc[0];
            let child_val = desc[1];
            let is_left = desc[2] == 1;

            if !nodes.contains_key(&parent_val) {
                nodes.insert(parent_val, Rc::new(RefCell::new(TreeNode::new(parent_val))));
            }
            if !nodes.contains_key(&child_val) {
                nodes.insert(child_val, Rc::new(RefCell::new(TreeNode::new(child_val))));
            }

            let parent_node = nodes.get(&parent_val).unwrap();
            let child_node = nodes.get(&child_val).unwrap();

            if is_left {
                parent_node.borrow_mut().left = Some(Rc::clone(child_node));
            } else {
                parent_node.borrow_mut().right = Some(Rc::clone(child_node));
            }

            children.insert(child_val, true);
        }

        for &parent_val in nodes.keys() {
            if !children.contains_key(&parent_val) {
                return nodes.get(&parent_val).map(|node| Rc::clone(node));
            }
        }

        None
    }
}

struct Solution;