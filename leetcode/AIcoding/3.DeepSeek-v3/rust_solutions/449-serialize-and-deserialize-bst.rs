use std::rc::Rc;
use std::cell::RefCell;
use std::iter::Peekable;
use std::str::Split;

struct Codec {}

impl Codec {
    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut res = String::new();
        Self::serialize_helper(&root, &mut res);
        res
    }

    fn serialize_helper(root: &Option<Rc<RefCell<TreeNode>>>, res: &mut String) {
        if let Some(node) = root {
            let node = node.borrow();
            res.push_str(&node.val.to_string());
            res.push(',');
            Self::serialize_helper(&node.left, res);
            Self::serialize_helper(&node.right, res);
        } else {
            res.push_str("#,");
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut iter = data.split(',').peekable();
        Self::deserialize_helper(&mut iter)
    }

    fn deserialize_helper(iter: &mut Peekable<Split<char>>) -> Option<Rc<RefCell<TreeNode>>> {
        let val_str = iter.next().unwrap();
        if val_str == "#" {
            return None;
        }
        let val = val_str.parse().unwrap();
        let mut node = TreeNode::new(val);
        node.left = Self::deserialize_helper(iter);
        node.right = Self::deserialize_helper(iter);
        Some(Rc::new(RefCell::new(node)))
    }
}

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