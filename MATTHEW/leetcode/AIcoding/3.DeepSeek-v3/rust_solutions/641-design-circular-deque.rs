struct MyCircularDeque {
    capacity: usize,
    front: usize,
    rear: usize,
    size: usize,
    data: Vec<i32>,
}

impl MyCircularDeque {
    fn new(k: i32) -> Self {
        let k = k as usize;
        Self {
            capacity: k,
            front: 0,
            rear: k - 1,
            size: 0,
            data: vec![0; k],
        }
    }

    fn insert_front(&mut self, value: i32) -> bool {
        if self.is_full() {
            false
        } else {
            self.front = (self.front + self.capacity - 1) % self.capacity;
            self.data[self.front] = value;
            self.size += 1;
            true
        }
    }

    fn insert_last(&mut self, value: i32) -> bool {
        if self.is_full() {
            false
        } else {
            self.rear = (self.rear + 1) % self.capacity;
            self.data[self.rear] = value;
            self.size += 1;
            true
        }
    }

    fn delete_front(&mut self) -> bool {
        if self.is_empty() {
            false
        } else {
            self.front = (self.front + 1) % self.capacity;
            self.size -= 1;
            true
        }
    }

    fn delete_last(&mut self) -> bool {
        if self.is_empty() {
            false
        } else {
            self.rear = (self.rear + self.capacity - 1) % self.capacity;
            self.size -= 1;
            true
        }
    }

    fn get_front(&self) -> i32 {
        if self.is_empty() {
            -1
        } else {
            self.data[self.front]
        }
    }

    fn get_rear(&self) -> i32 {
        if self.is_empty() {
            -1
        } else {
            self.data[self.rear]
        }
    }

    fn is_empty(&self) -> bool {
        self.size == 0
    }

    fn is_full(&self) -> bool {
        self.size == self.capacity
    }
}