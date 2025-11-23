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

pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
    let mut depth_map = HashMap::new();
    let mut parent_map = HashMap::new();

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, parent: Option<Rc<RefCell<TreeNode>>>, depth: i32, depth_map: &mut HashMap<i32, Vec<i32>>, parent_map: &mut HashMap<i32, i32>) {
        if let Some(n) = node {
            let val = n.borrow().val;
            depth_map.entry(depth).or_insert_with(Vec::new).push(val);
            if let Some(p) = parent {
                parent_map.insert(val, p.borrow().val);
            }

            dfs(n.borrow().left.clone(), Some(n.clone()), depth + 1, depth_map, parent_map);
            dfs(n.borrow().right.clone(), Some(n.clone()), depth + 1, depth_map, parent_map);
        }
    }

    dfs(root.clone(), None, 0, &mut depth_map, &mut parent_map);

    if let Some(depth_x) = depth_map.iter().find(|(_, v)| v.contains(&x)).map(|(d, _)| *d) {
        if let Some(depth_y) = depth_map.iter().find(|(_, v)| v.contains(&y)).map(|(d, _)| *d) {
            if depth_x == depth_y {
                if let (Some(parent_x), Some(parent_y)) = (parent_map.get(&x), parent_map.get(&y)) {
                    return parent_x != parent_y;
                }
            }
        }
    }

    false
}
}