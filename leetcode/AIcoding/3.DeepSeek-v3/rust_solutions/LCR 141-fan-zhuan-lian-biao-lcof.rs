impl Solution {
    pub fn trainning_plan(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut prev = None;
        while let Some(mut node) = head {
            let next = node.next.take();
            node.next = prev;
            prev = Some(node);
            head = next;
        }
        prev
    }
}