use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq, Clone)]
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

impl Solution {
    pub fn copy_random_list(head: Option<Box<Node>>) -> Option<Box<Node>> {
        let mut map = HashMap::new();
        let mut dummy = Node::new(0);
        let mut current = &head;
        let mut new_current = &mut dummy.next;

        while let Some(node) = current {
            *new_current = Some(Box::new(Node::new(node.val)));
            map.insert(node.as_ref() as *const Node, new_current.as_mut().unwrap().as_mut());
            current = &node.next;
            new_current = &mut new_current.as_mut().unwrap().next;
        }

        current = &head;
        new_current = &mut dummy.next;

        while let Some(node) = current {
            if let Some(random) = &node.random {
                if let Some(new_node) = map.get(&(random.as_ref() as *const Node)) {
                    new_current.as_mut().unwrap().random = Some(Box::new((**new_node).clone()));
                }
            }
            current = &node.next;
            new_current = &mut new_current.as_mut().unwrap().next;
        }

        dummy.next
    }
}