pub struct Node {
    pub val: i32,
    pub next: Option<Box<Node>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node { val, next: None }
    }
}

pub fn insert(head: Option<Box<Node>>, insert_val: i32) -> Option<Box<Node>> {
    let new_node = Some(Box::new(Node::new(insert_val)));
    if head.is_none() {
        new_node.as_ref().unwrap().next = new_node.clone();
        return new_node;
    }

    let mut current = head.as_ref();
    let mut prev = head.as_ref();

    loop {
        if let Some(cur) = current {
            if (cur.val <= insert_val && cur.next.as_ref().map_or(true, |n| n.val >= insert_val)) ||
               (cur.val > cur.next.as_ref().map_or(i32::MIN, |n| n.val) && 
                (insert_val > cur.val || insert_val < cur.next.as_ref().map_or(i32::MAX, |n| n.val))) {
                let mut new_node = new_node.clone();
                new_node.as_ref().unwrap().next = cur.next.clone();
                cur.next = new_node;
                return head;
            }
            prev = current;
            current = cur.next.as_ref();
            if current.is_none() {
                break;
            }
        }
    }

    if let Some(prev_node) = prev {
        let mut new_node = new_node.clone();
        new_node.as_ref().unwrap().next = head;
        prev_node.next = new_node;
    }

    head
}