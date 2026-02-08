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
    pub fn split_list_to_parts(mut head: Option<Box<ListNode>>, k: i32) -> Vec<Option<Box<ListNode>>> {
        let k_usize = k as usize;

        let mut count = 0;
        let mut current_ref = head.as_ref();
        while let Some(node) = current_ref {
            count += 1;
            current_ref = node.next.as_ref();
        }

        let base_size = count / k_usize;
        let mut extra_parts = count % k_usize;

        let mut result = Vec::with_capacity(k_usize);

        let mut current_head = head;

        for _i in 0..k_usize {
            let mut part_size = base_size;
            if extra_parts > 0 {
                part_size += 1;
                extra_parts -= 1;
            }

            if part_size == 0 {
                result.push(None);
                continue;
            }

            let mut part_start = current_head.take();

            let mut temp_ptr = &mut part_start;
            for _j in 0..(part_size - 1) {
                if let Some(node) = temp_ptr {
                    temp_ptr = &mut node.next;
                } else {
                    break;
                }
            }

            if let Some(node) = temp_ptr {
                current_head = node.next.take();
            } else {
                current_head = None;
            }

            result.push(part_start);
        }

        result
    }
}