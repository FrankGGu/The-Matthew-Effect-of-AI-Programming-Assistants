impl Solution {
    pub fn insertion_sort_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: i32::MIN, next: None }));
        while let Some(mut node) = head {
            head = node.next.take();
            let mut curr = dummy.as_mut();
            while curr.as_ref().unwrap().next.is_some() && curr.as_ref().unwrap().next.as_ref().unwrap().val < node.val {
                curr = curr.unwrap().next.as_mut();
            }
            node.next = curr.as_mut().unwrap().next.take();
            curr.as_mut().unwrap().next = Some(node);
        }
        dummy.unwrap().next
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
      val: val,
      next: None
    }
  }
}

struct Solution;