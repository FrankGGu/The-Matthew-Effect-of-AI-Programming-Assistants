#[derive(Debug, PartialEq, Eq, Clone)]
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

impl Solution {
    pub fn flatten(head: Option<Box<Node>>) -> Option<Box<Node>> {
        let mut head = head;
        let mut current = head.as_mut();

        while let Some(node) = current {
            if node.child.is_some() {
                let mut child = node.child.take();
                let mut next = node.next.take();

                let mut child_tail = child.as_mut();
                while let Some(tail_node) = child_tail {
                    if tail_node.next.is_none() {
                        break;
                    }
                    child_tail = tail_node.next.as_mut();
                }

                if let Some(child_head) = child.as_mut() {
                    child_head.prev = Some(Box::new(Node {
                        val: node.val,
                        prev: node.prev.take(),
                        next: None,
                        child: None,
                    }));
                }

                node.next = child;

                if let Some(next_head) = next.as_mut() {
                    if let Some(child_tail_node) = child_tail {
                         child_tail_node.next = next;

                         if let Some(next_node) = child_tail_node.next.as_mut() {
                            next_node.prev = Some(Box::new(Node {
                                val: child_tail_node.val,
                                prev: None,
                                next: None,
                                child: None
                            }));
                            if let Some(prev) = next_node.prev.as_mut() {
                                prev.next = Some(Box::new(Node {
                                    val: next_node.val,
                                    prev: None,
                                    next: None,
                                    child: None
                                }));
                                prev.next.as_mut().unwrap().prev = Some(Box::new(Node {
                                    val: child_tail_node.val,
                                    prev: None,
                                    next: None,
                                    child: None
                                }));
                            }

                            next_node.prev = Some(Box::new(Node {
                                val: child_tail_node.val,
                                prev: None,
                                next: None,
                                child: None
                            }));

                         }

                         let mut temp = child_tail_node.next.as_mut().unwrap();
                         temp.prev = Some(Box::new(Node{val: child_tail_node.val, prev: None, next: None, child: None}));

                    }

                }

            }
            current = node.next.as_mut();
        }

        head
    }
}

struct Solution;