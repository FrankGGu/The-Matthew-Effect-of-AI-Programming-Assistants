impl Solution {
    pub fn reverse_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut prev = None;
        let mut curr = head;

        while let Some(mut node) = curr {
            let next_temp = node.next;
            node.next = prev;
            prev = Some(node);
            curr = next_temp;
        }
        prev
    }
}