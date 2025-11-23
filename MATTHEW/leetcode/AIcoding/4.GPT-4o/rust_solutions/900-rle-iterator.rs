struct RLEIterator {
    nums: Vec<i32>,
    index: usize,
    remaining: i32,
}

impl RLEIterator {
    fn new(nums: Vec<i32>) -> Self {
        RLEIterator {
            nums,
            index: 0,
            remaining: 0,
        }
    }

    fn next(&mut self, n: i32) -> i32 {
        while self.index < self.nums.len() {
            if self.remaining == 0 {
                self.remaining = self.nums[self.index];
                self.index += 1;
                if self.index < self.nums.len() {
                    self.remaining = self.nums[self.index];
                    self.index += 1;
                }
            }
            if n <= self.remaining {
                self.remaining -= n;
                return self.nums[self.index - 1];
            }
            n -= self.remaining;
            self.remaining = 0;
        }
        -1
    }
}