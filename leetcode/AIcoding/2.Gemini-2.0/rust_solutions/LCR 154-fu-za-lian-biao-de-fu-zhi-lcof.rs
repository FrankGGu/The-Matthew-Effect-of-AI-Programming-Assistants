#[derive(PartialEq, Eq, Clone, Debug)]
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

use std::collections::HashMap;

impl Solution {
    pub fn copy_random_list(head: Option<Box<Node>>) -> Option<Box<Node>> {
        let mut map: HashMap<*const Node, *mut Node> = HashMap::new();
        let mut dummy_head = Node::new(0);
        let mut current = &mut dummy_head;
        let mut original = head.as_ref();

        while let Some(node) = original {
            let node_ptr = node.as_ref() as *const Node;
            if !map.contains_key(&node_ptr) {
                let new_node = Box::new(Node::new(node.val));
                map.insert(node_ptr, Box::into_raw(new_node));
            }

            let copied_node_ptr = *map.get(&node_ptr).unwrap();
            current.next = Some(unsafe { Box::from_raw(copied_node_ptr) });
            current = current.next.as_mut().unwrap();

            original = node.next.as_ref();
        }

        original = head.as_ref();
        let mut copied_head = dummy_head.next;
        let mut copied = copied_head.as_mut();

        while let Some(node) = original {
            if let Some(random_node) = node.random.as_ref() {
                let random_node_ptr = random_node.as_ref() as *const Node;
                if !map.contains_key(&random_node_ptr) {
                    let new_node = Box::new(Node::new(random_node.val));
                    map.insert(random_node_ptr, Box::into_raw(new_node));
                }
                let copied_random_ptr = *map.get(&random_node_ptr).unwrap();
                if let Some(copied_node) = copied.as_mut() {
                    copied_node.random = Some(unsafe { Box::from_raw(copied_random_ptr) });
                }
            }
            original = node.next.as_ref();
            if let Some(c) = copied.as_mut() {
                copied = c.next.as_mut();
            }
        }

        dummy_head.next
    }
}

struct Solution;