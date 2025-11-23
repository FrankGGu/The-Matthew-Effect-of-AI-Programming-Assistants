impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return true;
        }

        let mut head = head;
        let mut slow: &mut Option<Box<ListNode>> = &mut head;
        let mut fast: &mut Option<Box<ListNode>> = &mut head;
        let mut prev_slow_next: &mut Option<Box<ListNode>> = &mut head;

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            prev_slow_next = &mut slow.as_mut().unwrap().next;
            slow = &mut slow.as_mut().unwrap().next;
            fast = &mut fast.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        let mut second_half_head = prev_slow_next.take();

        if fast.is_some() {
            second_half_head = second_half_head.unwrap().next.take();
        }

        let reversed_second_half = Solution::reverse_list(second_half_head);

        let mut p1 = head.as_ref();
        let mut p2 = reversed_second_half.as_ref();
        let mut is_palindrome = true;

        while p2.is_some() {
            if p1.unwrap().val != p2.unwrap().val {
                is_palindrome = false;
                break;
            }
            p1 = p1.unwrap().next.as_ref();
            p2 = p2.unwrap().next.as_ref();
        }

        is_palindrome
    }

    fn reverse_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut prev = None;
        let mut curr = head;
        while let Some(mut node) = curr.take() {
            let next_temp = node.next.take();
            node.next = prev.take();
            prev = Some(node);
            curr = next_temp;
        }
        prev
    }
}