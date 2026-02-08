use std::mem;

impl Solution {
    pub fn middle_node(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head_mut = head;
        let mut slow = &mut head_mut;
        let mut fast = &mut head_mut;

        while fast.as_ref().and_then(|node| node.next.as_ref()).is_some() {
            slow = &mut slow.as_mut().unwrap().next;
            fast = &mut fast.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        mem::take(slow)
    }
}