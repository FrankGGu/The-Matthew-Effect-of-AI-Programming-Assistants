impl Solution {
    pub fn nodes_between_critical_points(head: Option<Box<ListNode>>) -> Vec<i32> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() || head.as_ref().unwrap().next.as_ref().unwrap().next.is_none() {
            return vec![-1, -1];
        }

        let mut critical_indices = Vec::new();
        let mut prev = head.as_ref().unwrap().val;
        let mut current = head.as_ref().unwrap().next.as_ref().unwrap().val;
        let mut index = 1;
        let mut node = head.as_ref().unwrap().next.as_ref().unwrap().next.as_ref();

        while let Some(n) = node {
            let next_val = n.val;
            if (current > prev && current > next_val) || (current < prev && current < next_val) {
                critical_indices.push(index);
            }
            prev = current;
            current = next_val;
            index += 1;
            node = n.next.as_ref();
        }

        if critical_indices.len() < 2 {
            return vec![-1, -1];
        }

        let min_distance = critical_indices.windows(2).map(|w| w[1] - w[0]).min().unwrap() as i32;
        let max_distance = (critical_indices.last().unwrap() - critical_indices.first().unwrap()) as i32;

        vec![min_distance, max_distance]
    }
}