impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let len1 = Self::get_len(&l1);
        let len2 = Self::get_len(&l2);

        let (mut head, carry) = Self::add_recursive(l1, l2, len1, len2);

        if carry > 0 {
            let mut new_head = ListNode::new(carry);
            new_head.next = head;
            head = Some(Box::new(new_head));
        }

        head
    }

    fn get_len(mut head: &Option<Box<ListNode>>) -> usize {
        let mut len = 0;
        while let Some(node) = head {
            len += 1;
            head = &node.next;
        }
        len
    }

    // Returns (head_of_sum_list, carry_to_next_level)
    fn add_recursive(
        l1: Option<Box<ListNode>>,
        l2: Option<Box<ListNode>>,
        len1: usize,
        len2: usize,
    ) -> (Option<Box<ListNode>>, i32) {
        if l1.is_none() && l2.is_none() {
            return (None, 0);
        }

        let (mut next_node, mut carry_from_next);
        let mut current_val1 = 0;
        let mut current_val2 = 0;

        if len1 > len2 {
            let mut node1 = l1.unwrap();
            current_val1 = node1.val;
            (next_node, carry_from_next) = Self::add_recursive(node1.next, l2, len1 - 1, len2);
        } else if len2 > len1 {
            let mut node2 = l2.unwrap();
            current_val2 = node2.val;
            (next_node, carry_from_next) = Self::add_recursive(l1, node2.next, len1, len2 - 1);
        } else {
            let mut node1 = l1.unwrap();
            let mut node2 = l2.unwrap();
            current_val1 = node1.val;
            current_val2 = node2.val;
            (next_node, carry_from_next) = Self::add_recursive(node1.next, node2.next, len1 - 1, len2 - 1);
        }

        let sum_val = current_val1 + current_val2 + carry_from_next;
        let current_digit = sum_val % 10;
        let carry_to_parent = sum_val / 10;

        let mut current_node = ListNode::new(current_digit);
        current_node.next = next_node;

        (Some(Box::new(current_node)), carry_to_parent)
    }
}