impl Solution {
    pub fn delete_middle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return None;
        }

        let mut slow = &head;
        let mut fast = &head;
        let mut prev = None;

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            prev = Some(slow);
            slow = &slow.as_ref().unwrap().next;
            fast = &fast.as_ref().unwrap().next.as_ref().unwrap().next;
        }

        if let Some(p) = prev {
            let mut p_mut = unsafe { &mut *(p as *const _ as *mut Option<&Box<ListNode>>) };
            if let Some(node) = p_mut {
                let next = node.as_ref().next.as_ref().unwrap().next.take();
                node.as_mut().next = next;
            }
        }

        head
    }
}