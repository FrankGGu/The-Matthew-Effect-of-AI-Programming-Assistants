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
    pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        match head {
            None => None,
            Some(mut node1) => {
                match node1.next {
                    None => Some(node1),
                    Some(mut node2) => {
                        node1.next = Solution::swap_pairs(node2.next);
                        node2.next = Some(node1);
                        Some(node2)
                    }
                }
            }
        }
    }
}