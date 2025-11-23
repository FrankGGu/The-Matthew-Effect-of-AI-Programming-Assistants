use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug)]
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

pub fn leaf_similar(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn get_leaves(root: Option<Rc<RefCell<TreeNode>>>, leaves: &mut Vec<i32>) {
        if let Some(node) = root {
            let node = node.borrow();
            if node.left.is_none() && node.right.is_none() {
                leaves.push(node.val);
            } else {
                get_leaves(node.left.clone(), leaves);
                get_leaves(node.right.clone(), leaves);
            }
        }
    }

    let mut leaves1 = Vec::new();
    let mut leaves2 = Vec::new();

    get_leaves(root1, &mut leaves1);
    get_leaves(root2, &mut leaves2);

    leaves1 == leaves2
}