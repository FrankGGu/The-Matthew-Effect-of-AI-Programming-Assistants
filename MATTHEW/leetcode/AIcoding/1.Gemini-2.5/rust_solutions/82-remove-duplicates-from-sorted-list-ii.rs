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

struct Solution;

impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode::new(0));
        dummy.next = head;

        let mut current_ptr: &mut Option<Box<ListNode>> = &mut dummy.next;

        while let Some(node) = current_ptr.as_mut() {
            if let Some(next_node) = node.next.as_mut() {
                if node.val == next_node.val {
                    let duplicate_val = node.val;

                    let mut temp_head = current_ptr.take().unwrap();

                    while let Some(mut current_temp_node) = temp_head {
                        if current_temp_node.val == duplicate_val {
                            temp_head = current_temp_node.next;
                        } else {
                            *current_ptr = Some(current_temp_node);
                            break;
                        }
                    }
                } else {
                    current_ptr = &mut node.next;
                }
            } else {
                break;
            }
        }

        dummy.next
    }
}