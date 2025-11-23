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
    pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut vec = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            vec.push(node.val);
            current = node.next;
        }
        vec.sort();

        let mut dummy = Some(Box::new(ListNode::new(0)));
        let mut tail = &mut dummy;
        for &val in &vec {
            if let Some(node) = tail {
                node.next = Some(Box::new(ListNode::new(val)));
                tail = &mut node.next;
            }
        }
        dummy.unwrap().next
    }
}

struct Solution;