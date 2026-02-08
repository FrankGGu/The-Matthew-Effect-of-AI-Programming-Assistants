use crate::structs::TreeNode;

impl Solution {
    pub fn delete_node(root: Option<Box<TreeNode>>, key: i32) -> Option<Box<TreeNode>> {
        if root.is_none() {
            return None;
        }

        let mut root = root;
        if key < root.as_ref()?.val {
            root.as_mut().unwrap().left = Self::delete_node(root.as_mut().unwrap().left.take(), key);
        } else if key > root.as_ref()?.val {
            root.as_mut().unwrap().right = Self::delete_node(root.as_mut().unwrap().right.take(), key);
        } else {
            if root.as_ref().unwrap().left.is_none() {
                return root.unwrap().right;
            } else if root.as_ref().unwrap().right.is_none() {
                return root.unwrap().left;
            }
            let mut min_larger_node = root.as_mut().unwrap().right.as_mut();
            while let Some(ref mut node) = min_larger_node {
                if node.left.is_none() {
                    break;
                }
                min_larger_node = node.left.as_mut();
            }
            if let Some(node) = min_larger_node {
                root.as_mut().unwrap().val = node.val;
                root.as_mut().unwrap().right = Self::delete_node(root.as_mut().unwrap().right.take(), node.val);
            }
        }
        root
    }
}