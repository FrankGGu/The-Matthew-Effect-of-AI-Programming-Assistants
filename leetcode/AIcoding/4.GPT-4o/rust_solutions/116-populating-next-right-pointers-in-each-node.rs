#[derive(Clone, PartialEq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Box<Node>>,
    pub right: Option<Box<Node>>,
    pub next: Option<Box<Node>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            left: None,
            right: None,
            next: None,
        }
    }
}

pub fn connect(root: Option<Box<Node>>) -> Option<Box<Node>> {
    let mut current = root;
    while current.is_some() {
        let mut next_level = None;
        let mut last = None;
        let mut node = current.clone();

        while let Some(mut n) = node {
            if let Some(left) = n.left.take() {
                if last.is_none() {
                    next_level = Some(left);
                } else {
                    last.as_mut().unwrap().next = Some(left);
                }
                last = Some(left);
            }
            if let Some(right) = n.right.take() {
                if last.is_none() {
                    next_level = Some(right);
                } else {
                    last.as_mut().unwrap().next = Some(right);
                }
                last = Some(right);
            }
            node = n.next.take();
        }
        current = next_level;
    }
    root
}