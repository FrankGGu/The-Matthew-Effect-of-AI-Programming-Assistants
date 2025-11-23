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

struct Solution;

impl Solution {
    pub fn merge_two_lists(mut list1: Option<Box<ListNode>>, mut list2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut current = &mut dummy_head;

        while list1.is_some() && list2.is_some() {
            let l1_val = list1.as_ref().unwrap().val;
            let l2_val = list2.as_ref().unwrap().val;

            if l1_val < l2_val {
                let mut node = list1.take().unwrap();
                list1 = node.next.take();
                current.as_mut().unwrap().next = Some(node);
            } else {
                let mut node = list2.take().unwrap();
                list2 = node.next.take();
                current.as_mut().unwrap().next = Some(node);
            }
            current = &mut current.as_mut().unwrap().next;
        }

        if list1.is_some() {
            current.as_mut().unwrap().next = list1;
        } else if list2.is_some() {
            current.as_mut().unwrap().next = list2;
        }

        dummy_head.unwrap().next
    }
}