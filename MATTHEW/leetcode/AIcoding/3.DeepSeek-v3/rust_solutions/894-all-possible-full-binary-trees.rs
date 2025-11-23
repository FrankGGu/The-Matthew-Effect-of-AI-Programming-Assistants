use std::rc::Rc;
use std::cell::RefCell;

type TreeNodeRef = Option<Rc<RefCell<TreeNode>>>;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: TreeNodeRef,
    pub right: TreeNodeRef,
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
    pub fn all_possible_fbt(n: i32) -> Vec<TreeNodeRef> {
        if n % 2 == 0 {
            return vec![];
        }
        let mut memo = std::collections::HashMap::new();
        Self::helper(n, &mut memo)
    }

    fn helper(n: i32, memo: &mut std::collections::HashMap<i32, Vec<TreeNodeRef>>) -> Vec<TreeNodeRef> {
        if let Some(res) = memo.get(&n) {
            return res.clone();
        }
        if n == 1 {
            return vec![Some(Rc::new(RefCell::new(TreeNode::new(0))))];
        }
        let mut res = Vec::new();
        for i in (1..n).step_by(2) {
            let left_trees = Self::helper(i, memo);
            let right_trees = Self::helper(n - 1 - i, memo);
            for left in &left_trees {
                for right in &right_trees {
                    let mut root = TreeNode::new(0);
                    root.left = left.clone();
                    root.right = right.clone();
                    res.push(Some(Rc::new(RefCell::new(root))));
                }
            }
        }
        memo.insert(n, res.clone());
        res
    }
}