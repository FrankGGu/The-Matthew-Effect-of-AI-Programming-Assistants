struct MyCircularQueue {
    queue: Vec<i32>,
    head: usize,
    tail: usize,
    size: usize,
    capacity: usize,
}

impl MyCircularQueue {
    fn new(k: i32) -> Self {
        MyCircularQueue {
            queue: vec![0; k as usize],
            head: 0,
            tail: 0,
            size: 0,
            capacity: k as usize,
        }
    }

    fn en_queue(&mut self, value: i32) -> bool {
        if self.size == self.capacity {
            return false;
        }
        self.queue[self.tail] = value;
        self.tail = (self.tail + 1) % self.capacity;
        self.size += 1;
        true
    }

    fn de_queue(&mut self) -> bool {
        if self.size == 0 {
            return false;
        }
        self.head = (self.head + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn front(&self) -> i32 {
        if self.size == 0 {
            return -1;
        }
        self.queue[self.head]
    }

    fn rear(&self) -> i32 {
        if self.size == 0 {
            return -1;
        }
        let rear_index = (self.tail + self.capacity - 1) % self.capacity;
        self.queue[rear_index]
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}