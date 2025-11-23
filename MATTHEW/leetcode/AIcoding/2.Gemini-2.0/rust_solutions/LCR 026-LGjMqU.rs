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

        let mut slow = head.clone();
        let mut fast = head.clone();

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            slow = slow.unwrap().next.clone();
            fast = fast.unwrap().next.clone().unwrap().next.clone();
        }

        let mut second_half = slow.unwrap().next.take();

        let mut prev = None;
        let mut curr = second_half;

        while let Some(mut node) = curr {
            let next = node.next.take();
            node.next = prev;
            prev = Some(node);
            curr = next;
        }

        let mut first = head.clone();
        let mut second = prev;

        while second.is_some() {
            let first_next = first.as_mut().unwrap().next.take();
            let second_next = second.as_mut().unwrap().next.take();

            first.as_mut().unwrap().next = second;
            second.as_mut().unwrap().next = first_next;

            first = first_next;
            second = second_next;
        }
    }
}