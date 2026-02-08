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
    pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut slow = head.as_ref();
        let mut fast = head.as_ref();

        while let (Some(s), Some(f)) = (slow, fast) {
            slow = s.next.as_ref();
            fast = f.next.as_ref().and_then(|n| n.next.as_ref());

            if slow.is_some() && fast.is_some() && slow == fast {
                let mut ptr1 = head;
                let mut ptr2 = slow.cloned();

                while let (Some(p1), Some(p2)) = (ptr1, ptr2) {
                    if p1 == p2 {
                        return Some(Box::new(p1.clone()));
                    }
                    ptr1 = p1.next;
                    ptr2 = p2.next.as_ref().map(|n| Box::new(n.clone()));
                }
            }

            if fast.is_none() {
                return None;
            }
        }

        None
    }
}

struct Solution;