impl Solution {
    pub fn reverse_k_group(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        if head.is_none() || k <= 1 {
            return head;
        }

        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut pre = &mut dummy;

        loop {
            let mut cur = pre.as_mut().unwrap().next.as_mut();
            let mut tail = pre.as_mut().unwrap();

            for _ in 0..k {
                match tail.next {
                    Some(mut node) => {
                        tail = node;
                    }
                    None => {
                        return dummy.unwrap().next;
                    }
                }
            }

            let mut next = tail.next.take();

            let mut prev = next;

            for _ in 0..k {
                let mut temp = cur.take().unwrap();
                cur = temp.next.take();
                temp.next = prev;
                prev = Some(temp);
            }

            pre.as_mut().unwrap().next = prev;

            let mut temp_pre = pre.as_mut().unwrap().next.as_mut();
            for _ in 0..k{
                temp_pre = temp_pre.unwrap().next.as_mut();
            }

            *pre = temp_pre.unwrap();
            pre.next = next;
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