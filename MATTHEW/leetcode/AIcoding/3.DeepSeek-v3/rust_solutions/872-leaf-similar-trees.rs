use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn leaf_similar(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn collect_leaves(root: Option<Rc<RefCell<TreeNode>>, leaves: &mut Vec<i32>) {
            if let Some(node) = root {
                let node = node.borrow();
                if node.left.is_none() && node.right.is_none() {
                    leaves.push(node.val);
                } else {
                    collect_leaves(node.left.clone(), leaves);
                    collect_leaves(node.right.clone(), leaves);
                }
            }
        }

        let mut leaves1 = Vec::new();
        let mut leaves2 = Vec::new();
        collect_leaves(root1, &mut leaves1);
        collect_leaves(root2, &mut leaves2);

        leaves1 == leaves2
    }
}