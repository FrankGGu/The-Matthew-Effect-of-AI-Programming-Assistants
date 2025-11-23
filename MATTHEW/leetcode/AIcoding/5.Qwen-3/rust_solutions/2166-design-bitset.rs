struct Bitset {
    bits: Vec<u8>,
    set_count: usize,
}

impl Bitset {
    fn new(size: i32) -> Self {
        let size = size as usize;
        Bitset {
            bits: vec![0; size],
            set_count: 0,
        }
    }

    fn fix(&mut self, idx: i32) {
        let idx = idx as usize;
        if self.bits[idx] == 0 {
            self.bits[idx] = 1;
            self.set_count += 1;
        }
    }

    fn unfix(&mut self, idx: i32) {
        let idx = idx as usize;
        if self.bits[idx] == 1 {
            self.bits[idx] = 0;
            self.set_count -= 1;
        }
    }

    fn flip(&mut self) {
        for i in 0..self.bits.len() {
            self.bits[i] ^= 1;
        }
        self.set_count = self.bits.len() - self.set_count;
    }

    fn is_fixed(&self, idx: i32) -> bool {
        self.bits[idx as usize] == 1
    }

    fn count(&self) -> i32 {
        self.set_count as i32
    }

    fn to_string(&self) -> String {
        self.bits.iter().map(|&b| b.to_string()).collect()
    }
}