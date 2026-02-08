use std::collections::BinaryHeap;
use std::cmp::Reverse;

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

impl PartialOrd for ListNode {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        self.val.partial_cmp(&other.val)
    }
}

impl Ord for ListNode {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.val.cmp(&other.val)
    }
}

struct Solution;

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();

        for list_node in lists {
            if let Some(node) = list_node {
                heap.push(Reverse(node));
            }
        }

        let mut dummy_head = Box::new(ListNode::new(0));
        let mut current_node = &mut dummy_head;

        while let Some(Reverse(mut node)) = heap.pop() {
            let next_list_node = node.next.take();

            current_node.next = Some(node);
            current_node = current_node.next.as_mut().unwrap();

            if let Some(next_list_node) = next_list_node {
                heap.push(Reverse(next_list_node));
            }
        }

        dummy_head.next
    }
}