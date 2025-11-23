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
    pub fn nodes_between_critical_points(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut values = Vec::new();
        let mut current = &head;
        while let Some(node) = current {
            values.push(node.val);
            current = &node.next;
        }

        if values.len() < 3 {
            return vec![-1, -1];
        }

        let mut critical_points_indices = Vec::new();
        for i in 1..values.len() - 1 {
            let prev_val = values[i - 1];
            let curr_val = values[i];
            let next_val = values[i + 1];

            if (prev_val < curr_val && curr_val > next_val) || (prev_val > curr_val && curr_val < next_val) {
                critical_points_indices.push(i);
            }
        }

        if critical_points_indices.len() < 2 {
            return vec![-1, -1];
        }

        let mut min_dist = std::i32::MAX;
        for i in 0..critical_points_indices.len() - 1 {
            let dist = critical_points_indices[i + 1] - critical_points_indices[i];
            if (dist as i32) < min_dist {
                min_dist = dist as i32;
            }
        }

        let max_dist = critical_points_indices.last().unwrap() - critical_points_indices.first().unwrap();

        vec![min_dist, max_dist as i32]
    }
}