#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

impl Solution {
    pub fn swap_nodes(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut len = 0;
        let mut current = head.as_ref();
        while let Some(node) = current {
            len += 1;
            current = node.next.as_ref();
        }

        let k = k as usize;
        let from_start_index = k - 1;
        let from_end_index = len - k;

        let mut from_start_node: Option<&mut ListNode> = None;
        let mut from_end_node: Option<&mut ListNode> = None;
        let mut current = head.as_mut();
        let mut index = 0;

        while let Some(node) = current {
            if index == from_start_index {
                from_start_node = Some(node);
            }
            if index == from_end_index {
                from_end_node = Some(node);
            }
            current = node.next.as_mut();
            index += 1;
        }

        if let (Some(start_node), Some(end_node)) = (from_start_node, from_end_node) {
            let temp = start_node.val;
            start_node.val = end_node.val;
            end_node.val = temp;
        }

        head
    }
}

struct Solution;