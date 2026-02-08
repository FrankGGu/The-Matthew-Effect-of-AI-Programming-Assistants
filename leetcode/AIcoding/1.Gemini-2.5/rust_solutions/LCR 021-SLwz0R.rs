impl Solution {
    pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode::new(0)));
        dummy.as_mut().unwrap().next = head;

        let mut first_ptr: &mut Option<Box<ListNode>> = &mut dummy;
        let mut second_ptr: &mut Option<Box<ListNode>> = &mut dummy;

        for _ in 0..=n {
            first_ptr = &mut first_ptr.as_mut().unwrap().next;
        }

        while first_ptr.is_some() {
            first_ptr = &mut first_ptr.as_mut().unwrap().next;
            second_ptr = &mut second_ptr.as_mut().unwrap().next;
        }

        let mut target_node = second_ptr.as_mut().unwrap().next.take();
        if let Some(mut boxed_target_node) = target_node {
            second_ptr.as_mut().unwrap().next = boxed_target_node.next.take();
        }

        dummy.unwrap().next
    }
}