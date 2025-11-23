use crate::TreeNode;

struct Solution;

impl Solution {
    pub fn recover_tree(root: &mut Option<Box<TreeNode>>) {
        let mut first = None;
        let mut second = None;
        let mut prev = None;

        fn inorder(node: &Option<Box<TreeNode>>, 
                   first: &mut Option<Box<TreeNode>>, 
                   second: &mut Option<Box<TreeNode>>, 
                   prev: &mut Option<i32>) {
            if let Some(n) = node {
                inorder(&n.left, first, second, prev);

                if let Some(p) = prev {
                    if p >= &n.val {
                        if first.is_none() {
                            *first = Some(n.clone());
                        }
                        *second = Some(n.clone());
                    }
                }
                *prev = Some(n.val);

                inorder(&n.right, first, second, prev);
            }
        }

        inorder(root, &mut first, &mut second, &mut None);

        if let (Some(first_node), Some(second_node)) = (first, second) {
            std::mem::swap(&mut first_node.val, &mut second_node.val);
        }
    }
}