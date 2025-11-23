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
    pub fn has_cycle(head: Option<Box<ListNode>>) -> bool {
        let mut slow = head.clone();
        let mut fast = head;

        while let Some(s) = slow {
            if let Some(f) = fast {
                if let Some(ff) = f.next {
                    if s.as_ref() as *const ListNode == ff.as_ref() as *const ListNode {
                        return true;
                    }
                    slow = s.next;
                    fast = ff.next;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }

        false
    }
}

struct Solution;