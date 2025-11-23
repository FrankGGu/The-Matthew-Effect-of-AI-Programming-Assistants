struct Bitset {
    internal_bits: Vec<u8>,
    num_ones: usize,
    size: usize,
    is_flipped: bool,
}

impl Bitset {
    fn new(size: i32) -> Self {
        Bitset {
            internal_bits: vec![0; size as usize],
            num_ones: 0,
            size: size as usize,
            is_flipped: false,
        }
    }

    fn fix(&mut self, idx: i32) {
        let idx_usize = idx as usize;
        if self.is_flipped {
            if self.internal_bits[idx_usize] == 1 {
                self.internal_bits[idx_usize] = 0;
                self.num_ones += 1;
            }
        } else {
            if self.internal_bits[idx_usize] == 0 {
                self.internal_bits[idx_usize] = 1;
                self.num_ones += 1;
            }
        }
    }

    fn unfix(&mut self, idx: i32) {
        let idx_usize = idx as usize;
        if self.is_flipped {
            if self.internal_bits[idx_usize] == 0 {
                self.internal_bits[idx_usize] = 1;
                self.num_ones -= 1;
            }
        } else {
            if self.internal_bits[idx_usize] == 1 {
                self.internal_bits[idx_usize] = 0;
                self.num_ones -= 1;
            }
        }
    }

    fn flip(&mut self) {
        self.is_flipped = !self.is_flipped;
        self.num_ones = self.size - self.num_ones;
    }

    fn all(&self) -> bool {
        self.num_ones == self.size
    }

    fn one(&self) -> bool {
        self.num_ones > 0
    }

    fn count(&self) -> i32 {
        self.num_ones as i32
    }

    fn to_string(&self) -> String {
        let mut s = String::with_capacity(self.size);
        if self.is_flipped {
            for &bit in self.internal_bits.iter() {
                if bit == 0 {
                    s.push('1');
                } else {
                    s.push('0');
                }
            }
        } else {
            for &bit in self.internal_bits.iter() {
                if bit == 0 {
                    s.push('0');
                } else {
                    s.push('1');
                }
            }
        }
        s
    }
}