use rand::Rng;

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

use std::cell::RefCell;
use std::rc::Rc;

struct Solution {
    head: Option<Box<ListNode>>
}

impl Solution {

    fn new(head: Option<Box<ListNode>>) -> Self {
        Solution { head }
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let mut reservoir = 0;
        let mut count = 0;
        let mut current = &self.head;

        while let Some(node) = current {
            count += 1;
            if rng.gen_range(0..count) == 0 {
                reservoir = node.val;
            }
            current = &node.next;
        }

        reservoir
    }
}