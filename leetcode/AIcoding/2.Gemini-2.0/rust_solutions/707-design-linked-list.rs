struct MyLinkedList {
    head: Option<Box<ListNode>>,
    size: i32,
}

#[derive(Debug, PartialEq, Eq, Clone)]
struct ListNode {
    val: i32,
    next: Option<Box<ListNode>>,
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
            current = &current.as_ref().unwrap().next;
        }

        current.as_ref().unwrap().val
    }

    fn add_at_head(&mut self, val: i32) {
        let new_head = Box::new(ListNode {
            val,
            next: self.head.take(),
        });
        self.head = Some(new_head);
        self.size += 1;
    }

    fn add_at_tail(&mut self, val: i32) {
        if self.head.is_none() {
            self.add_at_head(val);
            return;
        }

        let mut current = &mut self.head;
        while current.as_ref().unwrap().next.is_some() {
            current = &mut current.as_mut().unwrap().next;
        }

        current.as_mut().unwrap().next = Some(Box::new(ListNode {
            val,
            next: None,
        }));
        self.size += 1;
    }

    fn add_at_index(&mut self, index: i32, val: i32) {
        if index < 0 || index > self.size {
            return;
        }

        if index == 0 {
            self.add_at_head(val);
            return;
        }

        if index == self.size {
            self.add_at_tail(val);
            return;
        }

        let mut current = &mut self.head;
        for _ in 0..index - 1 {
            current = &mut current.as_mut().unwrap().next;
        }

        let new_node = Box::new(ListNode {
            val,
            next: current.as_mut().unwrap().next.take(),
        });
        current.as_mut().unwrap().next = Some(new_node);
        self.size += 1;
    }

    fn delete_at_index(&mut self, index: i32) {
        if index < 0 || index >= self.size || self.head.is_none() {
            return;
        }

        if index == 0 {
            self.head = self.head.take().unwrap().next;
            self.size -= 1;
            return;
        }

        let mut current = &mut self.head;
        for _ in 0..index - 1 {
            current = &mut current.as_mut().unwrap().next;
        }

        let next_node = current.as_mut().unwrap().next.take();
        if let Some(node) = next_node {
            current.as_mut().unwrap().next = node.next;
            self.size -= 1;
        }
    }
}