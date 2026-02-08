#[derive(Debug)]
struct MyLinkedList {
    head: Option<Box<Node>>,
    size: i32,
}

#[derive(Debug)]
struct Node {
    val: i32,
    next: Option<Box<Node>>,
}

impl MyLinkedList {
    fn new() -> Self {
        MyLinkedList { head: None, size: 0 }
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
        let new_node = Box::new(Node {
            val,
            next: self.head.take(),
        });
        self.head = Some(new_node);
        self.size += 1;
    }

    fn add_at_tail(&mut self, val: i32) {
        let new_node = Box::new(Node { val, next: None });
        if self.head.is_none() {
            self.head = Some(new_node);
        } else {
            let mut current = &mut self.head;
            while current.as_ref().unwrap().next.is_some() {
                current = &mut current.as_mut().unwrap().next;
            }
            current.as_mut().unwrap().next = Some(new_node);
        }
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
        let mut current = &mut self.head;
        for _ in 0..index - 1 {
            current = &mut current.as_mut().unwrap().next;
        }
        let new_node = Box::new(Node {
            val,
            next: current.as_mut().unwrap().next.take(),
        });
        current.as_mut().unwrap().next = Some(new_node);
        self.size += 1;
    }

    fn delete_at_index(&mut self, index: i32) {
        if index < 0 || index >= self.size {
            return;
        }
        if index == 0 {
            self.head = self.head.take().unwrap().next;
        } else {
            let mut current = &mut self.head;
            for _ in 0..index - 1 {
                current = &mut current.as_mut().unwrap().next;
            }
            let next = current.as_mut().unwrap().next.take();
            current.as_mut().unwrap().next = next.unwrap().next;
        }
        self.size -= 1;
    }
}