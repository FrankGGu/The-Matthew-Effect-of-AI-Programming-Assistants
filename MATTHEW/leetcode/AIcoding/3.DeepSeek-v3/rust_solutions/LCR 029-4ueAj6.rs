#[derive(PartialEq, Eq, Clone, Debug)]
pub struct Node {
    pub val: i32,
    pub next: Option<Box<Node>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node { next: None, val }
    }
}

impl Solution {
    pub fn insert(head: Option<Box<Node>>, insert_val: i32) -> Option<Box<Node>> {
        let mut new_node = Box::new(Node::new(insert_val));
        if head.is_none() {
            new_node.next = Some(new_node.clone());
            return Some(new_node);
        }

        let mut prev = head.as_ref().unwrap();
        let mut curr = prev.next.as_ref().unwrap();
        let mut found = false;

        loop {
            if (prev.val <= insert_val && insert_val <= curr.val) ||
               (prev.val > curr.val && (insert_val >= prev.val || insert_val <= curr.val)) {
                found = true;
                break;
            }
            prev = curr;
            curr = curr.next.as_ref().unwrap();
            if prev.as_ref() as *const _ == head.as_ref().unwrap().as_ref() as *const _ {
                break;
            }
        }

        new_node.next = Some(curr.clone());
        let mut prev_mut = prev.clone();
        prev_mut.next = Some(new_node);

        head
    }
}