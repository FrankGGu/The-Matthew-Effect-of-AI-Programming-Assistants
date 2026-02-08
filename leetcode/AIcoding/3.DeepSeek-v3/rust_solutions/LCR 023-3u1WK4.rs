impl Solution {
    pub fn get_intersection_node(head_a: Option<Box<ListNode>>, head_b: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut a = &head_a;
        let mut b = &head_b;
        while a != b {
            let next_a = match a {
                Some(node) => &node.next,
                None => &head_b,
            };
            let next_b = match b {
                Some(node) => &node.next,
                None => &head_a,
            };
            a = next_a;
            b = next_b;
        }
        a.clone()
    }
}