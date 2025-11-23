impl Solution {
    pub fn odd_even_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        let mut odd_curr = head.as_mut().unwrap();
        let mut even_head = odd_curr.next.take();
        let mut even_curr = even_head.as_mut().unwrap();

        while let Some(mut next_odd_node) = even_curr.next.take() {
            let next_even_node = next_odd_node.next.take();

            odd_curr.next = Some(next_odd_node);
            odd_curr = odd_curr.next.as_mut().unwrap();

            even_curr.next = next_even_node;
            if let Some(ref_to_next_even) = even_curr.next.as_mut() {
                even_curr = ref_to_next_even;
            } else {
                break;
            }
        }

        odd_curr.next = even_head;

        head
    }
}