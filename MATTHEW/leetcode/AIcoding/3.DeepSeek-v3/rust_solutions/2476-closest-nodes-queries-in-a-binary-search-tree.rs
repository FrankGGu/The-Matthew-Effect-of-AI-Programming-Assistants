use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn closest_nodes(root: Option<Rc<RefCell<TreeNode>>>, queries: Vec<i32>) -> Vec<Vec<i32>> {
        let mut sorted = Vec::new();
        Self::inorder(&root, &mut sorted);
        let mut res = Vec::new();
        for q in queries {
            let mut ans = vec![-1, -1];
            match sorted.binary_search(&q) {
                Ok(_) => {
                    ans[0] = q;
                    ans[1] = q;
                },
                Err(i) => {
                    if i > 0 {
                        ans[0] = sorted[i - 1];
                    }
                    if i < sorted.len() {
                        ans[1] = sorted[i];
                    }
                }
            }
            res.push(ans);
        }
        res
    }

    fn inorder(node: &Option<Rc<RefCell<TreeNode>>>, sorted: &mut Vec<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            Self::inorder(&n.left, sorted);
            sorted.push(n.val);
            Self::inorder(&n.right, sorted);
        }
    }
}