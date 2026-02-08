pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn nodes_between_critical_points(head: Option<Box<ListNode>>) -> Vec<i32> {
    let mut critical_points = Vec::new();
    let mut prev = None;
    let mut curr = head;
    let mut index = 0;

    while let Some(node) = curr {
        if let Some(next) = node.next {
            if (prev.is_some() && (prev.unwrap().val < node.val && next.val < node.val || prev.unwrap().val > node.val && next.val > node.val)) {
                critical_points.push(index);
            }
        }
        prev = Some(node.val);
        curr = node.next;
        index += 1;
    }

    if critical_points.len() < 2 {
        return vec![-1, -1];
    }

    let min_distance = critical_points.windows(2).map(|w| w[1] - w[0]).min().unwrap();
    let max_distance = critical_points.last().unwrap() - critical_points[0];

    vec![min_distance as i32, max_distance as i32]
}