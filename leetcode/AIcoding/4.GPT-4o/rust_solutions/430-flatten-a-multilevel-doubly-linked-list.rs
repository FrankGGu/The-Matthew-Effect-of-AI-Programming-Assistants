#[derive(Debug)]
pub struct Node {
    pub val: i32,
    pub prev: Option<Box<Node>>,
    pub next: Option<Box<Node>>,
    pub child: Option<Box<Node>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node {
            val,
            prev: None,
            next: None,
            child: None,
        }
    }
}

pub fn flatten(head: Option<Box<Node>>) -> Option<Box<Node>> {
    let mut stack = Vec::new();
    let mut current = head;
    let mut prev: Option<Box<Node>> = None;
    let mut new_head: Option<Box<Node>> = None;
    let mut tail: Option<Box<Node>> = None;

    while current.is_some() || !stack.is_empty() {
        while let Some(mut node) = current {
            if new_head.is_none() {
                new_head = Some(node.clone());
                tail = new_head.clone();
            } else {
                tail.as_mut().unwrap().next = Some(node.clone());
                node.prev = tail.take();
                tail = node.next.take();
            }
            current = node.child.take();
            if current.is_none() {
                current = node.next.take();
            }
            node.child = None;
            if let Some(ref mut t) = tail {
                t.prev = Some(node);
            }
            stack.push(node);
        }
        if let Some(mut node) = stack.pop() {
            current = node.next.take();
        }
    }
    new_head
}