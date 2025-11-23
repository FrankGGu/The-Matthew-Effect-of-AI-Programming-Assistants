struct MyCircularQueue {
    data: Vec<i32>,
    head: usize,
    tail: usize,
    size: usize,
    capacity: usize,
}

impl MyCircularQueue {
    fn new(k: i32) -> Self {
        let capacity = k as usize;
        MyCircularQueue {
            data: vec![0; capacity],
            head: 0,
            tail: 0,
            size: 0,
            capacity,
        }
    }

    fn en_queue(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }
        self.data[self.tail] = value;
        self.tail = (self.tail + 1) % self.capacity;
        self.size += 1;
        true
    }

    fn de_queue(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }
        self.head = (self.head + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn front(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }
        self.data[self.head]
    }

    fn rear(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }
        let rear_idx = (self.tail + self.capacity - 1) % self.capacity;
        self.data[rear_idx]
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}