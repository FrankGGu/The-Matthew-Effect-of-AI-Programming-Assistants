use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub next: Option<Box<Node>>,
    pub random: Option<Box<Node>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
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
        let mut ptr = &head;
        let mut dummy = Node::new(0);
        let mut tail = &mut dummy.next;

        while let Some(node) = ptr {
            let new_node = Box::new(Node::new(node.val));
            map.insert(node.as_ref() as *const Node, new_node.as_ref() as *const Node);
            *tail = Some(new_node);
            tail = &mut tail.as_mut().unwrap().next;
            ptr = &node.next;
        }

        let mut old_ptr = &head;
        let mut new_ptr = &dummy.next;

        while let (Some(old_node), Some(new_node)) = (old_ptr, new_ptr) {
            if let Some(random) = &old_node.random {
                let random_ptr = random.as_ref() as *const Node;
                new_node.random = Some(Box::new(*map.get(&random_ptr).unwrap()));
            }
            old_ptr = &old_node.next;
            new_ptr = &new_node.next;
        }

        dummy.next
    }
}