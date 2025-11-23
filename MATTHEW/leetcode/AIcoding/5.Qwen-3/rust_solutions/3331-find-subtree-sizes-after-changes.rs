impl Solution {

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

pub fn find_subtree_sizes_after_changes(
    root: Option<Rc<RefCell<TreeNode>>>,
    changes: Vec<Vec<i32>>,
) -> Vec<i32> {
    let mut result = Vec::new();
    let mut node_to_index = HashMap::new();
    let mut index_to_node = HashMap::new();

    let mut index = 0;
    fn dfs(
        node: &Option<Rc<RefCell<TreeNode>>>,
        index: &mut i32,
        node_to_index: &mut HashMap<Rc<RefCell<TreeNode>>, i32>,
        index_to_node: &mut HashMap<i32, Rc<RefCell<TreeNode>>>,
    ) {
        if let Some(n) = node {
            let n_clone = n.clone();
            *index += 1;
            node_to_index.insert(n_clone.clone(), *index);
            index_to_node.insert(*index, n_clone);
            dfs(&n.borrow().left, index, node_to_index, index_to_node);
            dfs(&n.borrow().right, index, node_to_index, index_to_node);
        }
    }

    dfs(&root, &mut index, &mut node_to_index, &mut index_to_node);

    let size = index as usize;
    let mut subtree_size = vec![1; size + 1];
    let mut visited = vec![false; size + 1];

    fn post_order(
        node: &Option<Rc<RefCell<TreeNode>>>,
        node_to_index: &HashMap<Rc<RefCell<TreeNode>>, i32>,
        subtree_size: &mut Vec<i32>,
        visited: &mut Vec<bool>,
    ) {
        if let Some(n) = node {
            let index = *node_to_index.get(&n.clone()).unwrap();
            if visited[index as usize] {
                return;
            }
            visited[index as usize] = true;
            post_order(&n.borrow().left, node_to_index, subtree_size, visited);
            post_order(&n.borrow().right, node_to_index, subtree_size, visited);
            if let Some(left) = &n.borrow().left {
                let left_idx = *node_to_index.get(&left.clone()).unwrap();
                subtree_size[index as usize] += subtree_size[left_idx as usize];
            }
            if let Some(right) = &n.borrow().right {
                let right_idx = *node_to_index.get(&right.clone()).unwrap();
                subtree_size[index as usize] += subtree_size[right_idx as usize];
            }
        }
    }

    post_order(&root, &node_to_index, &mut subtree_size, &mut visited);

    for change in changes {
        let old_val = change[0];
        let new_val = change[1];
        let idx = *node_to_index.get(&Rc::clone(&index_to_node[&old_val])).unwrap();
        subtree_size[idx as usize] = 1;
        let mut stack = vec![index_to_node[&old_val].clone()];
        while let Some(node) = stack.pop() {
            let idx = *node_to_index.get(&node).unwrap();
            let mut current = node.borrow_mut();
            let left = current.left.take();
            let right = current.right.take();
            if let Some(left) = left {
                let left_idx = *node_to_index.get(&left).unwrap();
                subtree_size[idx as usize] += subtree_size[left_idx as usize];
                stack.push(left);
            }
            if let Some(right) = right {
                let right_idx = *node_to_index.get(&right).unwrap();
                subtree_size[idx as usize] += subtree_size[right_idx as usize];
                stack.push(right);
            }
        }
    }

    for i in 1..=size {
        result.push(subtree_size[i as usize]);
    }

    result
}
}