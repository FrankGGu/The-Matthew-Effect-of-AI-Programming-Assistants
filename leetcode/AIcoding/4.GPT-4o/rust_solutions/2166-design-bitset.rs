pub struct Bitset {
    bits: Vec<bool>,
    ones: usize,
    flipped: bool,
}

impl Bitset {
    pub fn new(size: usize) -> Self {
        Self {
            bits: vec![false; size],
            ones: 0,
            flipped: false,
        }
    }

    pub fn fix(&mut self, idx: usize) {
        if self.flipped {
            if !self.bits[idx] {
                self.bits[idx] = true;
                self.ones += 1;
            }
        } else {
            if self.bits[idx] {
                self.bits[idx] = false;
                self.ones -= 1;
            }
        }
    }

    pub fn unfix(&mut self, idx: usize) {
        if self.flipped {
            if self.bits[idx] {
                self.bits[idx] = false;
                self.ones -= 1;
            }
        } else {
            if !self.bits[idx] {
                self.bits[idx] = true;
                self.ones += 1;
            }
        }
    }

    pub fn flip(&mut self) {
        self.flipped = !self.flipped;
        self.ones = self.bits.len() - self.ones;
    }

    pub fn all(&self) -> bool {
        self.ones == self.bits.len()
    }

    pub fn one(&self) -> bool {
        self.ones > 0
    }

    pub fn count(&self) -> usize {
        self.ones
    }

    pub fn to_string(&self) -> String {
        self.bits.iter().map(|&b| if b ^ self.flipped { '1' } else { '0' }).collect()
    }
}