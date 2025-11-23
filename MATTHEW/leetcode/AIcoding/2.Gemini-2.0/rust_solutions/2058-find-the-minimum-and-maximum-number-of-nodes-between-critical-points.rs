#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

impl Solution {
    pub fn nodes_between_critical_points(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut critical_points: Vec<i32> = Vec::new();
        let mut current = head;
        let mut index = 0;
        let mut prev_val = i32::MIN;
        let mut next_node = match current {
            Some(ref node) => node.next.as_ref(),
            None => None,
        };
        while let Some(node) = current {
            match next_node {
                Some(next) => {
                    if node.val > prev_val && node.val > next.val.clone() {
                        critical_points.push(index);
                    } else if node.val < prev_val && node.val < next.val.clone() {
                        critical_points.push(index);
                    }
                }
                None => {}
            }
            prev_val = node.val.clone();
            current = node.next;
            index += 1;
            next_node = match current {
                Some(ref node) => node.next.as_ref(),
                None => None,
            };
        }

        if critical_points.len() < 2 {
            return vec![-1, -1];
        }

        let mut min_dist = i32::MAX;
        for i in 0..critical_points.len() - 1 {
            min_dist = min_dist.min(critical_points[i + 1] - critical_points[i]);
        }

        let max_dist = critical_points.last().unwrap() - critical_points.first().unwrap();

        vec![min_dist, max_dist]
    }
}