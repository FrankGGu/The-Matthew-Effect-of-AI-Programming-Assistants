struct Allocator {
    memory: Vec<Option<usize>>,
    size: usize,
}

impl Allocator {
    fn new(size: usize) -> Self {
        Allocator {
            memory: vec![None; size],
            size,
        }
    }

    fn allocate(&mut self, size: usize, mID: usize) -> i32 {
        let mut count = 0;
        let mut start = 0;

        for i in 0..self.size {
            if self.memory[i].is_none() {
                count += 1;
            } else {
                count = 0;
                start = i + 1;
            }

            if count == size {
                for j in start..start + size {
                    self.memory[j] = Some(mID);
                }
                return start as i32;
            }
        }
        -1
    }

    fn free(&mut self, mID: usize) -> i32 {
        let mut freed = 0;

        for i in 0..self.size {
            if self.memory[i] == Some(mID) {
                self.memory[i] = None;
                freed += 1;
            }
        }

        freed as i32
    }
}