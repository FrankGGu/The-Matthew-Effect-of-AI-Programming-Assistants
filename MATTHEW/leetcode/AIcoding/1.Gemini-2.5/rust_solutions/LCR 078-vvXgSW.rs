use std::collections::BinaryHeap;
use std::cmp::{Reverse, Ordering};

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
  }
}

#[derive(Eq, PartialEq)]
struct HeapNode(Box<ListNode>);

impl Ord for HeapNode {
    fn cmp(&self, other: &Self) -> Ordering {
        self.0.val.cmp(&other.0.val)
    }
}

impl PartialOrd for HeapNode {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();

        for list_head in lists {
            if let Some(node) = list_head {
                heap.push(Reverse(HeapNode(node)));
            }
        }

        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut current_tail = &mut dummy_head;

        while let Some(Reverse(HeapNode(mut node))) = heap.pop() {
            let next_node_option = node.next.take();

            if let Some(ref mut tail_node) = current_tail {
                tail_node.next = Some(node);
                current_tail = &mut tail_node.next;
            }

            if let Some(next_node) = next_node_option {
                heap.push(Reverse(HeapNode(next_node)));
            }
        }

        dummy_head.unwrap().next
    }
}