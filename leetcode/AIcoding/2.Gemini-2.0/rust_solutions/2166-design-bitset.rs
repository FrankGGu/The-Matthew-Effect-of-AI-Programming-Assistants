struct Bitset {
    bits: Vec<bool>,
    size: usize,
    count: usize,
    flipped: bool,
}

impl Bitset {
    fn new(size: i32) -> Self {
        let size = size as usize;
        Bitset {
            bits: vec![false; size],
            size,
            count: 0,
            flipped: false,
        }
    }

    fn fix(&mut self, idx: i32) {
        let idx = idx as usize;
        let current = if self.flipped {
            self.bits[idx]
        } else {
            !self.bits[idx]
        };

        if !current {
            self.bits[idx] = !self.bits[idx];
            self.count += 1;
        }
    }

    fn unfix(&mut self, idx: i32) {
        let idx = idx as usize;
        let current = if self.flipped {
            self.bits[idx]
        } else {
            !self.bits[idx]
        };

        if current {
            self.bits[idx] = !self.bits[idx];
            self.count -= 1;
        }
    }

    fn flip(&mut self) {
        self.flipped = !self.flipped;
        self.count = self.size - self.count;
    }

    fn all(&self) -> bool {
        self.count == self.size
    }

    fn one(&self) -> bool {
        self.count > 0
    }

    fn count(&self) -> i32 {
        self.count as i32
    }

    fn to_string(&self) -> String {
        let mut result = String::new();
        for &bit in &self.bits {
            if self.flipped {
                result.push(if bit { '0' } else { '1' });
            } else {
                result.push(if bit { '1' } else { '0' });
            }
        }
        result
    }
}