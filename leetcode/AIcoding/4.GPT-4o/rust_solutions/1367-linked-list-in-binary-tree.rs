pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl Solution {
    pub fn is_sub_path(head: Option<Box<ListNode>>, root: Option<Box<TreeNode>>) -> bool {
        let mut root = root;
        let head = head.as_ref();
        let mut stack = vec![];
        if let Some(root_node) = root {
            stack.push((root_node, head));
        }

        while let Some((node, list_head)) = stack.pop() {
            if node.val == list_head.map_or(-1, |n| n.val) {
                if list_head.is_none() {
                    return true;
                }

                if let Some(left) = node.left.clone() {
                    stack.push((left, list_head.and_then(|n| n.next)));
                }
                if let Some(right) = node.right.clone() {
                    stack.push((right, list_head.and_then(|n| n.next)));
                }
            }
            if let Some(left) = node.left {
                stack.push((left, head));
            }
            if let Some(right) = node.right {
                stack.push((right, head));
            }
        }
        false
    }
}