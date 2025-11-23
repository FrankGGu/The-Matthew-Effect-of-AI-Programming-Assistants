struct MyCircularDeque {
    data: Vec<i32>,
    head: usize,
    tail: usize,
    size: usize,
    capacity: usize,
}

impl MyCircularDeque {
    fn new(k: i32) -> Self {
        MyCircularDeque {
            data: vec![0; k as usize],
            head: 0,
            tail: 0,
            size: 0,
            capacity: k as usize,
        }
    }

    fn insert_front(&mut self, value: i32) -> bool {
        if self.size == self.capacity {
            return false;
        }
        self.head = (self.head + self.capacity - 1) % self.capacity;
        self.data[self.head] = value;
        self.size += 1;
        true
    }

    fn insert_last(&mut self, value: i32) -> bool {
        if self.size == self.capacity {
            return false;
        }
        self.data[self.tail] = value;
        self.tail = (self.tail + 1) % self.capacity;
        self.size += 1;
        true
    }

    fn delete_front(&mut self) -> bool {
        if self.size == 0 {
            return false;
        }
        self.head = (self.head + 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn delete_last(&mut self) -> bool {
        if self.size == 0 {
            return false;
        }
        self.tail = (self.tail + self.capacity - 1) % self.capacity;
        self.size -= 1;
        true
    }

    fn get_front(&self) -> i32 {
        if self.size == 0 {
            return -1;
        }
        self.data[self.head]
    }

    fn get_rear(&self) -> i32 {
        if self.size == 0 {
            return -1;
        }
        self.data[(self.tail + self.capacity - 1) % self.capacity]
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}