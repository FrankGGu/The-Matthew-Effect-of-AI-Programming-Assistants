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
    pub fn split_list_to_parts(head: Option<Box<ListNode>>, k: i32) -> Vec<Option<Box<ListNode>>> {
        let mut len = 0;
        let mut current = head.as_ref();
        while let Some(node) = current {
            len += 1;
            current = node.next.as_ref();
        }

        let base_size = len / k;
        let extra = len % k;

        let mut result = Vec::new();
        let mut current = head;

        for i in 0..k {
            let mut part_size = base_size;
            if i < extra {
                part_size += 1;
            }

            if part_size == 0 {
                result.push(None);
                continue;
            }

            let mut part_head = current.take();
            let mut part_tail = part_head.as_mut();

            for _ in 1..part_size {
                if let Some(node) = part_tail {
                    part_tail = node.next.as_mut();
                }
            }

            let mut next_head = None;
            if let Some(node) = part_tail {
                next_head = node.next.take();
            }

            result.push(part_head);
            current = next_head;
        }

        result
    }
}