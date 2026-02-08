struct Allocator {
    memory: Vec<i32>,
}

impl Allocator {
    fn new(n: i32) -> Self {
        Allocator {
            memory: vec![0; n as usize],
        }
    }

    fn allocate(&mut self, size: i32, m_id: i32) -> i32 {
        let mut count = 0;
        let size = size as usize;
        for i in 0..self.memory.len() {
            if self.memory[i] == 0 {
                count += 1;
                if count == size {
                    let start = i + 1 - size;
                    for j in start..=i {
                        self.memory[j] = m_id;
                    }
                    return start as i32;
                }
            } else {
                count = 0;
            }
        }
        -1
    }

    fn free(&mut self, m_id: i32) -> i32 {
        let mut count = 0;
        for i in 0..self.memory.len() {
            if self.memory[i] == m_id {
                self.memory[i] = 0;
                count += 1;
            }
        }
        count
    }
}