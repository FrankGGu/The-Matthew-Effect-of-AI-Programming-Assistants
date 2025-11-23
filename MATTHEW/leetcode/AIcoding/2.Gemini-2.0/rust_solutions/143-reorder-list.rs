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

impl Solution {
    pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return;
        }

        let mut slow = head.as_mut();
        let mut fast = head.as_mut();

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            slow = slow.unwrap().next.as_mut();
            fast = fast.unwrap().next.as_mut().unwrap().next.as_mut();
        }

        let mut second_half = slow.unwrap().next.take();

        let mut prev = None;
        let mut current = second_half;

        while let Some(mut node) = current {
            current = node.next.take();
            node.next = prev;
            prev = Some(node);
        }

        let mut first = head.take();
        let mut second = prev;
        let mut dummy = ListNode::new(0);
        let mut tail = &mut dummy.next;

        while first.is_some() || second.is_some() {
            if let Some(mut node) = first.take() {
                first = node.next.take();
                *tail = Some(node);
                tail = &mut tail.as_mut().unwrap().next;
            }
            if let Some(mut node) = second.take() {
                second = node.next.take();
                *tail = Some(node);
                tail = &mut tail.as_mut().unwrap().next;
            }
        }

        *head = dummy.next;
    }
}

struct Solution;