use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn find_duplicate_subtrees(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut map = HashMap::new();
        let mut res = Vec::new();
        Self::serialize(root, &mut map, &mut res);
        res
    }

    fn serialize(
        root: Option<Rc<RefCell<TreeNode>>>,
        map: &mut HashMap<String, i32>,
        res: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
    ) -> String {
        if let Some(node) = root {
            let node = node.borrow();
            let s = format!(
                "({},{},{})",
                Self::serialize(node.left.clone(), map, res),
                node.val,
                Self::serialize(node.right.clone(), map, res)
            );
            *map.entry(s.clone()).or_insert(0) += 1;
            if map[&s] == 2 {
                res.push(Some(Rc::new(RefCell::new(TreeNode {
                    val: node.val,
                    left: node.left.clone(),
                    right: node.right.clone(),
                }))));
            }
            s
        } else {
            "#".to_string()
        }
    }
}