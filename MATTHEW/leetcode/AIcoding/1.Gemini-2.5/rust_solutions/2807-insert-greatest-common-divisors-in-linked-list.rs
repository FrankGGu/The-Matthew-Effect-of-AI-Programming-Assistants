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
    fn gcd(mut a: i32, mut b: i32) -> i32 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }

    pub fn insert_greatest_common_divisors(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        let mut head_mut = head;
        let mut current_ptr: &mut Option<Box<ListNode>> = &mut head_mut;

        while let Some(current_node) = current_ptr.as_mut() {
            if let Some(next_node) = current_node.next.as_ref() {
                let val1 = current_node.val;
                let val2 = next_node.val;
                let gcd_val = Self::gcd(val1, val2);

                let mut new_gcd_node = Box::new(ListNode::new(gcd_val));

                let original_next = current_node.next.take();
                new_gcd_node.next = original_next;
                current_node.next = Some(new_gcd_node);

                current_ptr = &mut current_node.next.as_mut().unwrap().next;
            } else {
                break;
            }
        }

        head_mut
    }
}