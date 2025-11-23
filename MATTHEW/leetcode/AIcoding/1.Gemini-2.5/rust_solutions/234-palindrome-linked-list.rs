impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return true;
        }

        let mut head_mut = head;

        let mut slow_ptr = &mut head_mut;
        let mut fast_ptr = &mut head_mut;
        let mut prev_slow_next: &mut Option<Box<ListNode>> = &mut head_mut;

        while fast_ptr.is_some() && fast_ptr.as_ref().unwrap().next.is_some() {
            prev_slow_next = &mut slow_ptr.as_mut().unwrap().next;
            slow_ptr = &mut slow_ptr.as_mut().unwrap().next;
            fast_ptr = &mut fast_ptr.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        let mut second_half_head = prev_slow_next.take();

        if fast_ptr.is_some() {
            second_half_head = second_half_head.unwrap().next.take();
        }

        let mut reversed_second_half = Solution::reverse_list(second_half_head);

        let mut p1 = head_mut;
        let mut p2 = reversed_second_half;
        let mut is_palindrome = true;

        while p1.is_some() && p2.is_some() {
            if p1.as_ref().unwrap().val != p2.as_ref().unwrap().val {
                is_palindrome = false;
                break;
            }
            p1 = p1.unwrap().next;
            p2 = p2.unwrap().next;
        }

        is_palindrome
    }

    fn reverse_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut prev = None;
        let mut current = head;
        while let Some(mut node) = current.take() {
            let next_node = node.next.take();
            node.next = prev.take();
            prev = Some(node);
            current = next_node;
        }
        prev
    }
}