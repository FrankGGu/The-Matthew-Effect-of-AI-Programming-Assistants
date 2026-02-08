impl Solution {
    pub fn delete_middle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut slow = &head;
        let mut fast = &head;
        let mut prev: Option<Box<ListNode>> = None;
        let mut count = 0;

        while let Some(ref node) = fast {
            count += 1;
            fast = &node.next;
            if let Some(ref next_node) = node.next {
                count += 1;
                fast = &next_node.next;
            }
        }

        if count == 1 {
            return None;
        }

        let middle_index = count / 2;
        let mut index = 0;
        let mut current = head;

        while let Some(ref node) = current {
            if index == middle_index {
                if let Some(mut prev_node) = prev {
                    prev_node.next = node.next.clone();
                    return Some(prev_node);
                }
            }
            prev = current;
            current = node.next.clone();
            index += 1;
        }

        head
    }
}