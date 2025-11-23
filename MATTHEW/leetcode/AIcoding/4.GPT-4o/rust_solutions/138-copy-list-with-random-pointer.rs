#[derive(Clone, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub next: Option<Box<Node>>,
    pub random: Option<Box<Node>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node {
            val,
            next: None,
            random: None,
        }
    }
}

pub fn copy_random_list(head: Option<Box<Node>>) -> Option<Box<Node>> {
    use std::collections::HashMap;

    let mut map = HashMap::new();
    let mut current = head.as_ref();

    while let Some(node) = current {
        map.insert(node.as_ref() as *const _, Box::new(Node::new(node.val)));
        current = node.next.as_ref().map(|n| n.as_ref() as *const _);
    }

    current = head.as_ref();
    while let Some(node) = current {
        if let Some(cloned_node) = map.get(&(node as *const _)) {
            cloned_node.next = node.next.as_ref().and_then(|n| map.get(&(n as *const _))).map(|n| n.clone());
            cloned_node.random = node.random.as_ref().and_then(|n| map.get(&(n as *const _))).map(|n| n.clone());
        }
        current = node.next.as_ref().map(|n| n.as_ref() as *const _);
    }

    map.get(&(head.as_ref()? as *const _)).cloned()
}