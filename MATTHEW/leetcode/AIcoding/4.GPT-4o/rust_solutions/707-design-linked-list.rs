#[derive(Default)]
struct Node {
    val: i32,
    next: Option<Box<Node>>,
}

struct MyLinkedList {
    head: Option<Box<Node>>,
    size: i32,
}

impl MyLinkedList {

    fn new() -> Self {
        MyLinkedList {
            head: None,
            size: 0,
        }
    }

    fn get(&self, index: i32) -> i32 {
        if index < 0 || index >= self.size {
            return -1;
        }
        let mut current = &self.head;
        for _ in 0..index {
            if let Some(ref node) = current {
                current = &node.next;
            }
        }
        current.as_ref().map_or(-1, |node| node.val)
    }

    fn add_at_head(&mut self, val: i32) {
        let new_node = Some(Box::new(Node { val, next: self.head.take() }));
        self.head = new_node;
        self.size += 1;
    }

    fn add_at_tail(&mut self, val: i32) {
        let new_node = Some(Box::new(Node { val, next: None }));
        if self.head.is_none() {
            self.head = new_node;
        } else {
            let mut current = &mut self.head;
            while let Some(ref mut node) = current {
                if node.next.is_none() {
                    node.next = new_node;
                    break;
                }
                current = &mut node.next;
            }
        }
        self.size += 1;
    }

    fn add_at_index(&mut self, index: i32, val: i32) {
        if index < 0 || index > self.size {
            return;
        }
        if index == 0 {
            self.add_at_head(val);
        } else {
            let mut current = &mut self.head;
            for _ in 0..index-1 {
                if let Some(ref mut node) = current {
                    current = &mut node.next;
                }
            }
            let new_node = Some(Box::new(Node { val, next: current.take() }));
            if let Some(ref mut node) = current {
                node.next = new_node;
            }
            self.size += 1;
        }
    }

    fn delete_at_index(&mut self, index: i32) {
        if index < 0 || index >= self.size {
            return;
        }
        if index == 0 {
            self.head = self.head.take().and_then(|node| node.next);
        } else {
            let mut current = &mut self.head;
            for _ in 0..index-1 {
                if let Some(ref mut node) = current {
                    current = &mut node.next;
                }
            }
            if let Some(ref mut node) = current {
                node.next = node.next.take().and_then(|node| node.next);
            }
        }
        self.size -= 1;
    }
}