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
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head = Some(Box::new(ListNode::new(0)));
        let mut tail = &mut head;
        let mut carry = 0;

        let mut l1_curr = l1;
        let mut l2_curr = l2;

        while l1_curr.is_some() || l2_curr.is_some() || carry > 0 {
            let mut sum = carry;

            if let Some(node) = l1_curr {
                sum += node.val;
                l1_curr = node.next;
            }

            if let Some(node) = l2_curr {
                sum += node.val;
                l2_curr = node.next;
            }

            carry = sum / 10;
            let digit = sum % 10;

            tail.as_mut().unwrap().next = Some(Box::new(ListNode::new(digit)));
            tail = &mut tail.as_mut().unwrap().next;
        }

        head.unwrap().next
    }
}

struct Solution;