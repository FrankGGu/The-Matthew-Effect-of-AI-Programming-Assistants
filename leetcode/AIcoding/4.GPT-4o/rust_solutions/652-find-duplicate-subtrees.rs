use std::collections::HashMap;
use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq, Hash)]
struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn find_duplicate_subtrees(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut map = HashMap::new();
        let mut result = Vec::new();

        fn serialize(node: &Option<Rc<RefCell<TreeNode>>>, map: &mut HashMap<String, i32>, result: &mut Vec<Option<Rc<RefCell<TreeNode>>>>) -> String {
            if let Some(n) = node {
                let n = n.borrow();
                let left = serialize(&n.left, map, result);
                let right = serialize(&n.right, map, result);
                let subtree = format!("{}({}{})", n.val, left, right);
                let count = map.entry(subtree.clone()).or_insert(0);
                if *count == 1 {
                    result.push(Some(Rc::clone(n)));
                }
                *count += 1;
                subtree
            } else {
                "#".to_string()
            }
        }

        serialize(&root, &mut map, &mut result);
        result
    }
}