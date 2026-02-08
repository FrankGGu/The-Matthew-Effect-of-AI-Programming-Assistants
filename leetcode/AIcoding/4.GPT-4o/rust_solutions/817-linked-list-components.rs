pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { val, next: None }
    }
}

pub fn num_components(head: Option<Box<ListNode>>, G: Vec<i32>) -> i32 {
    let set: std::collections::HashSet<i32> = G.into_iter().collect();
    let mut current = head;
    let mut count = 0;
    let mut in_component = false;

    while let Some(node) = current {
        if set.contains(&node.val) {
            if !in_component {
                count += 1;
                in_component = true;
            }
        } else {
            in_component = false;
        }
        current = node.next;
    }

    count
}