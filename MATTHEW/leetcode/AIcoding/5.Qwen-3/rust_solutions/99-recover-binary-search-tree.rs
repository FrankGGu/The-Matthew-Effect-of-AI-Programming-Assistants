pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

pub fn recover_tree(root: &mut Option<Box<TreeNode>>) {
    let mut first = None;
    let mut second = None;
    let mut prev = None;

    fn inorder_traversal(
        root: &Option<Box<TreeNode>>,
        first: &mut Option<Box<TreeNode>>,
        second: &mut Option<Box<TreeNode>>,
        prev: &mut Option<Box<TreeNode>>,
    ) {
        if let Some(node) = root {
            inorder_traversal(&node.left, first, second, prev);
            if let Some(p) = prev.as_ref() {
                if p.val > node.val {
                    if first.is_none() {
                        *first = Some(Box::new(TreeNode {
                            val: p.val,
                            left: None,
                            right: None,
                        }));
                    }
                    *second = Some(Box::new(TreeNode {
                        val: node.val,
                        left: None,
                        right: None,
                    }));
                }
            }
            *prev = Some(Box::new(TreeNode {
                val: node.val,
                left: None,
                right: None,
            }));
            inorder_traversal(&node.right, first, second, prev);
        }
    }

    inorder_traversal(root, &mut first, &mut second, &mut prev);

    if let (Some(f), Some(s)) = (first, second) {
        let temp = f.val;
        f.val = s.val;
        s.val = temp;
    }
}