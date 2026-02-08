#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  pub fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
  }
}

impl Solution {
    pub fn double_it(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let carry = Self::double_recursive(&mut head);

        if carry > 0 {
            let mut new_head = Box::new(ListNode::new(carry));
            new_head.next = head;
            Some(new_head)
        } else {
            head
        }
    }

    fn double_recursive(node_option: &mut Option<Box<ListNode>>) -> i32 {
        if let Some(node) = node_option {
            let carry_from_next = Self::double_recursive(&mut node.next);
            let new_val = node.val * 2 + carry_from_next;
            node.val = new_val % 10;
            new_val / 10
        } else {
            0
        }
    }
}