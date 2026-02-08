impl Solution {
    pub fn insert(head: Option<Box<ListNode>>, insert_val: i32) -> Option<Box<ListNode>> {
        let mut new_node = Some(Box::new(ListNode::new(insert_val)));

        match head {
            None => {
                new_node.as_mut().unwrap().next = new_node.clone();
                new_node
            }
            Some(mut head_node) => {
                let mut prev = &mut head_node;
                let mut curr = prev.next.as_mut().unwrap();
                let head_val = prev.val;

                loop {
                    if prev.val <= insert_val && insert_val <= curr.val {
                        break;
                    }

                    if prev.val > curr.val && (insert_val >= prev.val || insert_val <= curr.val) {
                        break;
                    }

                    if curr.as_ref().unwrap().next.as_ref().unwrap().val == head_val {
                        break;
                    }

                    let mut next_node = curr.next.as_mut().unwrap();
                    prev = curr;
                    curr = next_node;
                }

                let next = prev.next.take();
                prev.next = new_node;
                prev.next.as_mut().unwrap().next = next;

                Some(head_node)
            }
        }
    }
}

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      val,
      next: None
    }
  }
}

struct Solution;