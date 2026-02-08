#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;

impl Solution {
    pub fn tree_to_doubly_list(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        if root.is_none() {
            return None;
        }

        let mut head = None;
        let mut prev = None;

        fn inorder(node: Option<&Box<TreeNode>>, head: &mut Option<Box<TreeNode>>, prev: &mut Option<Box<TreeNode>>) {
            if let Some(n) = node {
                inorder(n.left.as_ref(), head, prev);

                if let Some(ref mut p) = prev {
                    p.right = Some(Box::new(TreeNode { val: n.val, left: Some(p.clone()), right: None }));
                    p.right.as_mut().unwrap().left = Some(p.clone());
                } else {
                    *head = Some(Box::new(TreeNode { val: n.val, left: None, right: None }));
                }
                *prev = head.clone();

                inorder(n.right.as_ref(), head, prev);
            }
        }

        inorder(root.as_ref(), &mut head, &mut prev);

        if let Some(ref mut h) = head {
            let mut tail = h.clone();
            while let Some(t) = tail.right.take() {
                tail = t;
            }
            tail.right = Some(h.clone());
            h.left = Some(tail);
        }

        head
    }
}