#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

struct Solution;

impl Solution {
    pub fn reverse_nodes_in_even_length_groups(
        head: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode::new(0));
        dummy.next = head;

        let mut prev_group_end_ptr = &mut dummy;
        let mut group_num = 1;

        while prev_group_end_ptr.next.is_some() {
            let mut current_node_traversal_opt = prev_group_end_ptr.next.as_mut();
            let mut count = 0;
            let mut group_end_node_ref: Option<&mut Box<ListNode>> = None;
            let mut node_after_group_next_field_ref: Option<&mut Option<Box<ListNode>>> = None;

            for _ in 0..group_num {
                if let Some(node) = current_node_traversal_opt {
                    count += 1;
                    group_end_node_ref = Some(node);
                    node_after_group_next_field_ref = Some(&mut node.next);
                    current_node_traversal_opt = node.next.as_mut();
                } else {
                    node_after_group_next_field_ref = None;
                    break;
                }
            }

            if count % 2 == 0 {
                let mut node_after_group = node_after_group_next_field_ref.map_or(None, |opt_box| opt_box.take());
                let mut group_head = prev_group_end_ptr.next.take();

                let (new_head, new_tail) =
                    Self::reverse_sublist_vec(group_head, count);

                prev_group_end_ptr.next = new_head;
                prev_group_end_ptr = new_tail.as_mut().unwrap();
                prev_group_end_ptr.next = node_after_group;
            } else {
                prev_group_end_ptr = group_end_node_ref.unwrap();
            }
            group_num += 1;
        }

        dummy.next
    }

    fn reverse_sublist_vec(
        head: Option<Box<ListNode>>,
        count: usize,
    ) -> (Option<Box<ListNode>>, Option<Box<ListNode>>) {
        let mut nodes: Vec<Box<ListNode>> = Vec::with_capacity(count);
        let mut current = head;

        for _ in 0..count {
            if let Some(mut node) = current.take() {
                current = node.next.take();
                nodes.push(node);
            }
        }

        let mut new_tail_of_reversed = nodes.remove(0);

        nodes.reverse();

        let mut new_head_segment = None;
        let mut temp_ptr = &mut new_head_segment;

        for mut node in nodes.into_iter() {
            node.next = None;
            *temp_ptr = Some(node);
            temp_ptr = &mut temp_ptr.as_mut().unwrap().next;
        }

        new_tail_of_reversed.next = None;
        *temp_ptr = Some(new_tail_of_reversed);

        (new_head_segment, temp_ptr.as_mut().unwrap())
    }
}