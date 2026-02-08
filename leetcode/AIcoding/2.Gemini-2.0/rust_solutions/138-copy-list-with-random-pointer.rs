use std::collections::HashMap;

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

impl Solution {
    pub fn copy_random_list(head: Option<Box<Node>>) -> Option<Box<Node>> {
        let mut map: HashMap<*const Node, *mut Node> = HashMap::new();
        let mut dummy_head = Box::new(Node::new(0));
        let mut current = &mut dummy_head;
        let mut original = head.as_ref();

        while let Some(node) = original {
            let node_ptr = node as *const Node;
            if !map.contains_key(&node_ptr) {
                let new_node = Box::new(Node::new(node.val));
                map.insert(node_ptr, Box::into_raw(new_node));
            }
            current.next = Some(unsafe { Box::from_raw(map[&node_ptr]) });
            current = current.next.as_mut().unwrap();

            if let Some(random_node) = node.random.as_ref() {
                let random_ptr = random_node as *const Node;
                if !map.contains_key(&random_ptr) {
                    let new_random_node = Box::new(Node::new(random_node.val));
                    map.insert(random_ptr, Box::into_raw(new_random_node));
                }
                current.random = Some(unsafe { Box::from_raw(map[&random_ptr]) });
            }

            original = node.next.as_ref();
        }

        dummy_head.next
    }
}

struct Solution;