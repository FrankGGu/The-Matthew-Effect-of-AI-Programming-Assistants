#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      val: val,
      next: None
    }
  }
}
impl Solution {
    pub fn delete_node(mut node: Option<Box<ListNode>>) {
        if let Some(mut n) = node {
            let mut next_node = n.next.take().unwrap();
            n.val = next_node.val;
            n.next = next_node.next;
        }
    }
}