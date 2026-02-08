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
    pub fn partition(head: Option<Box<ListNode>>, x: i32) -> Option<Box<ListNode>> {
        let mut less_head = None;
        let mut greater_head = None;
        let mut less_tail = &mut less_head;
        let mut greater_tail = &mut greater_head;

        let mut current = head;

        while let Some(mut node) = current {
            current = node.next.take();
            if node.val < x {
                match less_tail {
                    None => {
                        *less_tail = Some(node);
                        less_tail = &mut less_tail.as_mut().unwrap().next;
                    }
                    Some(_) => {
                        less_tail.as_mut().unwrap().next = Some(node);
                        less_tail = &mut less_tail.as_mut().unwrap().next;
                    }
                }
            } else {
                match greater_tail {
                    None => {
                        *greater_tail = Some(node);
                        greater_tail = &mut greater_tail.as_mut().unwrap().next;
                    }
                    Some(_) => {
                        greater_tail.as_mut().unwrap().next = Some(node);
                        greater_tail = &mut greater_tail.as_mut().unwrap().next;
                    }
                }
            }
        }

        match less_tail {
            None => greater_head,
            Some(_) => {
                less_tail.as_mut().unwrap().next = greater_head;
                less_head
            }
        }
    }
}

struct Solution;