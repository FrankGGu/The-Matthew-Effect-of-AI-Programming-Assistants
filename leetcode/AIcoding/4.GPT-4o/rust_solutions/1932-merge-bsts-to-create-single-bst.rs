use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn can_merge(trees: Vec<Option<Rc<RefCell<TreeNode>>>>) -> Option<Rc<RefCell<TreeNode>>> {
    use std::collections::HashMap;

    let mut roots = Vec::new();
    let mut child_count = HashMap::new();

    for tree in &trees {
        if let Some(root) = tree {
            let root_val = root.borrow().val;
            roots.push(root.clone());
            child_count.insert(root_val, 0);
            if let Some(left) = &root.borrow().left {
                let left_val = left.borrow().val;
                child_count.insert(left_val, child_count.get(&left_val).unwrap_or(&0) + 1);
            }
            if let Some(right) = &root.borrow().right {
                let right_val = right.borrow().val;
                child_count.insert(right_val, child_count.get(&right_val).unwrap_or(&0) + 1);
            }
        }
    }

    let mut root_node = None;
    for tree in &trees {
        if let Some(root) = tree {
            let val = root.borrow().val;
            if child_count.get(&val).unwrap_or(&0) == &0 {
                if root_node.is_none() {
                    root_node = Some(root.clone());
                } else {
                    return None;
                }
            }
        }
    }

    if root_node.is_none() {
        return None;
    }

    let mut nodes = Vec::new();
    let mut in_order = |node: Option<Rc<RefCell<TreeNode>>>| {
        if let Some(n) = node {
            in_order(n.borrow().left.clone());
            nodes.push(n.borrow().val);
            in_order(n.borrow().right.clone());
        }
    };

    in_order(root_node.clone());

    nodes.sort_unstable();
    let unique_nodes: Vec<i32> = nodes.into_iter().collect();

    fn build_bst(nums: &[i32]) -> Option<Rc<RefCell<TreeNode>>> {
        if nums.is_empty() {
            return None;
        }
        let mid = nums.len() / 2;
        let mut root = Rc::new(RefCell::new(TreeNode::new(nums[mid])));
        root.borrow_mut().left = build_bst(&nums[..mid]);
        root.borrow_mut().right = build_bst(&nums[mid + 1..]);
        Some(root)
    }

    build_bst(&unique_nodes)
}