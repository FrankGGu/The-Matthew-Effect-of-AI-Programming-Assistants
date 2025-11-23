use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn create_binary_tree(descriptions: Vec<Vec<i32>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes: HashMap<i32, Rc<RefCell<TreeNode>>> = HashMap::new();
        let mut child_nodes: HashSet<i32> = HashSet::new();

        for desc in descriptions {
            let parent_val = desc[0];
            let child_val = desc[1];
            let is_left = desc[2];

            let parent_node = nodes.entry(parent_val).or_insert_with(|| {
                Rc::new(RefCell::new(TreeNode::new(parent_val)))
            }).clone();

            let child_node = nodes.entry(child_val).or_insert_with(|| {
                Rc::new(RefCell::new(TreeNode::new(child_val)))
            }).clone();

            child_nodes.insert(child_val);

            if is_left == 1 {
                parent_node.borrow_mut().left = Some(child_node);
            } else {
                parent_node.borrow_mut().right = Some(child_node);
            }
        }

        let mut root_val = -1; 
        for (val, _) in &nodes {
            if !child_nodes.contains(val) {
                root_val = *val;
                break;
            }
        }

        nodes.get(&root_val).cloned()
    }
}