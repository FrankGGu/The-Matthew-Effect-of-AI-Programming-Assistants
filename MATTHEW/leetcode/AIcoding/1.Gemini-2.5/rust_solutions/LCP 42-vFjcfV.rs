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
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn insert_greatest_common_divisors(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current_ptr = head.as_mut();

        while let Some(curr_node_box) = current_ptr {
            if let Some(mut next_node_box) = curr_node_box.next.take() {
                let val1 = curr_node_box.val;
                let val2 = next_node_box.val;
                let common_divisor = Self::gcd(val1, val2);

                let mut new_node = Box::new(ListNode::new(common_divisor));

                new_node.next = Some(next_node_box);
                curr_node_box.next = Some(new_node);

                current_ptr = curr_node_box.next.as_mut().unwrap().next.as_mut();
            } else {
                break;
            }
        }

        head
    }
}