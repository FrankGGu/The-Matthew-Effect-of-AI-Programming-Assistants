struct Bitset {
    size: usize,
    bits: Vec<u64>,
    flipped: bool,
}

impl Bitset {
    fn new(size: i32) -> Self {
        let size = size as usize;
        let chunks = (size + 63) / 64;
        Bitset {
            size,
            bits: vec![0; chunks],
            flipped: false,
        }
    }

    fn fix(&mut self, idx: i32) {
        let idx = idx as usize;
        let chunk = idx / 64;
        let bit = idx % 64;
        if self.flipped {
            self.bits[chunk] &= !(1 << bit);
        } else {
            self.bits[chunk] |= 1 << bit;
        }
    }

    fn unfix(&mut self, idx: i32) {
        let idx = idx as usize;
        let chunk = idx / 64;
        let bit = idx % 64;
        if self.flipped {
            self.bits[chunk] |= 1 << bit;
        } else {
            self.bits[chunk] &= !(1 << bit);
        }
    }

    fn flip(&mut self) {
        self.flipped = !self.flipped;
    }

    fn all(&self) -> bool {
        let full_chunks = self.size / 64;
        let remaining_bits = self.size % 64;
        let mask = if remaining_bits == 0 {
            u64::MAX
        } else {
            (1 << remaining_bits) - 1
        };

        if self.flipped {
            for i in 0..full_chunks {
                if self.bits[i] != u64::MAX {
                    return false;
                }
            }
            if remaining_bits != 0 && (self.bits[full_chunks] & mask) != mask {
                return false;
            }
        } else {
            for i in 0..full_chunks {
                if self.bits[i] != 0 {
                    return false;
                }
            }
            if remaining_bits != 0 && (self.bits[full_chunks] & mask) != 0 {
                return false;
            }
        }
        true
    }

    fn one(&self) -> bool {
        if self.flipped {
            for &chunk in &self.bits {
                if chunk != u64::MAX {
                    return true;
                }
            }
        } else {
            for &chunk in &self.bits {
                if chunk != 0 {
                    return true;
                }
            }
        }
        false
    }

    fn count(&self) -> i32 {
        let mut cnt = 0;
        for &chunk in &self.bits {
            cnt += chunk.count_ones();
        }
        if self.flipped {
            (self.size as i32) - (cnt as i32)
        } else {
            cnt as i32
        }
    }

    fn to_string(&self) -> String {
        let mut res = String::with_capacity(self.size);
        for i in 0..self.size {
            let chunk = i / 64;
            let bit = i % 64;
            let set = (self.bits[chunk] & (1 << bit)) != 0;
            if set ^ self.flipped {
                res.push('1');
            } else {
                res.push('0');
            }
        }
        res
    }
}