use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn create_binary_tree(descriptions: Vec<Vec<i32>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes = HashMap::new();
        let mut children = HashMap::new();

        for desc in descriptions {
            let parent_val = desc[0];
            let child_val = desc[1];
            let is_left = desc[2] == 1;

            let parent = nodes.entry(parent_val).or_insert_with(|| {
                Rc::new(RefCell::new(TreeNode::new(parent_val)))
            }).clone();

            let child = nodes.entry(child_val).or_insert_with(|| {
                Rc::new(RefCell::new(TreeNode::new(child_val)))
            }).clone();

            if is_left {
                parent.borrow_mut().left = Some(child.clone());
            } else {
                parent.borrow_mut().right = Some(child.clone());
            }

            children.insert(child_val, true);
        }

        for desc in descriptions {
            let parent_val = desc[0];
            if !children.contains_key(&parent_val) {
                return nodes.get(&parent_val).cloned();
            }
        }

        None
    }
}