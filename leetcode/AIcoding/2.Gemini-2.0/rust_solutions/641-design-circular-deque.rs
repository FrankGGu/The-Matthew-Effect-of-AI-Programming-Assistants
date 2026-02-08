struct MyCircularDeque {
    deque: Vec<i32>,
    head: usize,
    tail: usize,
    capacity: usize,
    size: usize,
}

impl MyCircularDeque {
    fn new(k: i32) -> Self {
        let capacity = k as usize;
        MyCircularDeque {
            deque: vec![0; capacity],
            head: 0,
            tail: 0,
            capacity,
            size: 0,
        }
    }

    fn insert_front(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }

        if self.is_empty() {
            self.deque[self.head] = value;
        } else {
            self.head = (self.head + self.capacity - 1) % self.capacity;
            self.deque[self.head] = value;
        }

        self.size += 1;
        true
    }

    fn insert_last(&mut self, value: i32) -> bool {
        if self.is_full() {
            return false;
        }

        if self.is_empty() {
            self.deque[self.tail] = value;
        } else {
            self.tail = (self.tail + 1) % self.capacity;
            self.deque[self.tail] = value;
        }

        self.size += 1;
        true
    }

    fn delete_front(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }

        self.head = (self.head + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn delete_last(&mut self) -> bool {
        if self.is_empty() {
            return false;
        }

        self.tail = (self.tail + self.capacity - 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn get_front(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }

        self.deque[self.head]
    }

    fn get_rear(&self) -> i32 {
        if self.is_empty() {
            return -1;
        }

        self.deque[self.tail]
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}