use std::collections::HashMap;

struct Allocator {
    memory: Vec<i32>,
    allocations: HashMap<i32, Vec<(usize, usize)>>,
}

impl Allocator {
    fn new(n: i32) -> Self {
        Allocator {
            memory: vec![0; n as usize],
            allocations: HashMap::new(),
        }
    }

    fn allocate(&mut self, size: i32, m_id: i32) -> i32 {
        let n = self.memory.len();
        let size_usize = size as usize;

        if size_usize == 0 || size_usize > n {
            return -1;
        }

        for i in 0..=(n - size_usize) {
            let mut is_free = true;
            for j in 0..size_usize {
                if self.memory[i + j] != 0 {
                    is_free = false;
                    break;
                }
            }

            if is_free {
                for j in 0..size_usize {
                    self.memory[i + j] = m_id;
                }
                self.allocations.entry(m_id).or_default().push((i, size_usize));
                return i as i32;
            }
        }
        -1
    }

    fn free(&mut self, m_id: i32) -> i32 {
        let mut total_freed_size = 0;

        if let Some(blocks) = self.allocations.remove(&m_id) {
            for (start_idx, block_size) in blocks {
                for j in 0..block_size {
                    self.memory[start_idx + j] = 0;
                }
                total_freed_size += block_size;
            }
        }
        total_freed_size as i32
    }
}