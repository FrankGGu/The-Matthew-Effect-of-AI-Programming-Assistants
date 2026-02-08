#[derive(Clone, Debug)]
pub struct Node {
    pub val: i32,
    pub prev: Option<Box<Node>>,
    pub next: Option<Box<Node>>,
    pub child: Option<Box<Node>>,
}

pub struct Solution;

impl Solution {
    pub fn flatten(head: Option<Box<Node>>) -> Option<Box<Node>> {
        let mut dummy = Box::new(Node {
            val: 0,
            prev: None,
            next: None,
            child: None,
        });
        let mut prev = &mut dummy;

        let mut stack = vec![head];
        while let Some(node) = stack.pop() {
            if let Some(mut n) = node {
                prev.next = Some(n.clone());
                n.prev = Some(Box::new(prev.clone()));

                if n.next.is_some() {
                    stack.push(n.next);
                }
                if n.child.is_some() {
                    stack.push(n.child);
                    n.child = None;
                }
                prev = prev.next.as_mut().unwrap();
            }
        }
        dummy.next.as_mut().unwrap().prev = Some(Box::new(dummy));
        dummy.next
    }
}