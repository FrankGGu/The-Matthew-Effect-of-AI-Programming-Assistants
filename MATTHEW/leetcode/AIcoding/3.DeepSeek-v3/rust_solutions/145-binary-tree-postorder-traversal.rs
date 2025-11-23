use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn postorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut res = Vec::new();
        Self::helper(root.as_ref(), &mut res);
        res
    }

    fn helper(node: Option<&Rc<RefCell<TreeNode>>>, res: &mut Vec<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            Self::helper(n.left.as_ref(), res);
            Self::helper(n.right.as_ref(), res);
            res.push(n.val);
        }
    }
}