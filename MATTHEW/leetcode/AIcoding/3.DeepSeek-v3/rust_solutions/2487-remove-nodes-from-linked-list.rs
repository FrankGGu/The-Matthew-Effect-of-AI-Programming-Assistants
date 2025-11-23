impl Solution {
    pub fn remove_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut stack = Vec::new();
        let mut current = head;

        while let Some(mut node) = current {
            current = node.next.take();
            while let Some(last) = stack.last() {
                if last.val < node.val {
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(node);
        }

        let mut next = None;
        while let Some(mut node) = stack.pop() {
            node.next = next;
            next = Some(node);
        }
        next
    }
}