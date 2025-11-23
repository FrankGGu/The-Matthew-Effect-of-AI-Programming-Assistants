use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn flip_match_voyage(root: Option<Rc<RefCell<TreeNode>>>, voyage: Vec<i32>) -> Vec<i32> {
        let mut res = Vec::new();
        let mut index = 0;
        if Self::dfs(&root, &voyage, &mut index, &mut res) {
            res
        } else {
            vec![-1]
        }
    }

    fn dfs(
        node: &Option<Rc<RefCell<TreeNode>>>,
        voyage: &[i32],
        index: &mut usize,
        res: &mut Vec<i32>,
    ) -> bool {
        if let Some(n) = node {
            let n = n.borrow();
            if n.val != voyage[*index] {
                return false;
            }
            *index += 1;
            if n.left.is_some() && n.left.as_ref().unwrap().borrow().val != voyage[*index] {
                res.push(n.val);
                Self::dfs(&n.right, voyage, index, res) && Self::dfs(&n.left, voyage, index, res)
            } else {
                Self::dfs(&n.left, voyage, index, res) && Self::dfs(&n.right, voyage, index, res)
            }
        } else {
            true
        }
    }
}