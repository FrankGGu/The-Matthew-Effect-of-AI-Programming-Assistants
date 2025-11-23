impl Solution {
    fn reverse_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut prev = None;
        while let Some(mut node) = head.take() {
            let next_temp = node.next.take();
            node.next = prev;
            prev = Some(node);
            head = next_temp;
        }
        prev
    }

    pub fn remove_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut reversed_head = Self::reverse_list(head);

        let mut current_max = 0; 
        let mut result_head = None;

        while let Some(mut node) = reversed_head.take() {
            let next_node = node.next.take();

            if node.val >= current_max {
                current_max = node.val;
                node.next = result_head;
                result_head = Some(node);
            }

            reversed_head = next_node;
        }

        result_head
    }
}