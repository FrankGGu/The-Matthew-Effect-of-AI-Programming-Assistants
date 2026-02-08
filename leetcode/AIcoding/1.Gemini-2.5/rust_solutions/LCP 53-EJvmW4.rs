struct Solution;

impl Solution {
    pub fn max_total_reward(mut reward_values: Vec<i32>) -> i32 {
        reward_values.sort_unstable();
        reward_values.dedup();

        let max_possible_sum = 2000 * 1000; 
        let mut dp = BitSet::new(max_possible_sum);

        for &r_val in reward_values.iter() {
            let r_val = r_val as usize;
            let new_sums = dp.and_mask_range(r_val).shl(r_val);
            dp.or_assign(&new_sums);
        }

        dp.max_set_bit() as i32
    }
}

struct BitSet {
    bits: Vec<u64>,
    max_idx: usize,
}

impl BitSet {
    fn new(max_idx_inclusive: usize) -> Self {
        let num_u64 = (max_idx_inclusive + 1 + 63) / 64;
        let mut bits = vec![0; num_u64];
        bits[0] |= 1;
        BitSet { bits, max_idx: max_idx_inclusive }
    }

    fn or_assign(&mut self, other: &BitSet) {
        for i in 0..self.bits.len().min(other.bits.len()) {
            self.bits[i] |= other.bits[i];
        }
    }

    fn shl(&self, shift_amount: usize) -> BitSet {
        let mut new_bs = BitSet::new(self.max_idx);
        new_bs.bits.fill(0);

        if shift_amount > self.max_idx {
            return new_bs;
        }

        let word_shift = shift_amount / 64;
        let bit_shift = shift_amount % 64;

        for i in (0..self.bits.len()).rev() {
            if self.bits[i] == 0 { continue; }

            if i + word_shift < new_bs.bits.len() {
                new_bs.bits[i + word_shift] |= self.bits[i] << bit_shift;
            }

            if bit_shift > 0 && i + word_shift + 1 < new_bs.bits.len() {
                new_bs.bits[i + word_shift + 1] |= self.bits[i] >> (64 - bit_shift);
            }
        }

        let max_idx_word = self.max_idx / 64;
        let max_idx_bit = self.max_idx % 64;
        if max_idx_word < new_bs.bits.len() {
            new_bs.bits[max_idx_word] &= (1 << (max_idx_bit + 1)) - 1;
        }
        for i in (max_idx_word + 1)..new_bs.bits.len() {
            new_bs.bits[i] = 0;
        }

        new_bs
    }

    fn and_mask_range(&self, limit: usize) -> BitSet {
        let mut new_bs = BitSet::new(self.max_idx);
        new_bs.bits.fill(0);

        if limit == 0 { return new_bs; }

        let limit_idx_inclusive = (limit - 1).min(self.max_idx); 

        let limit_word_idx = limit_idx_inclusive / 64;
        let limit_bit_idx = limit_idx_inclusive % 64;

        for i in 0..self.bits.len() {
            if i < limit_word_idx {
                new_bs.bits[i] = self.bits[i];
            } else if i == limit_word_idx {
                new_bs.bits[i] = self.bits[i] & ((1 << (limit_bit_idx + 1)) - 1);
                break;
            } else {
                break;
            }
        }
        new_bs
    }

    fn max_set_bit(&self) -> usize {
        for i in (0..self.bits.len()).rev() {
            if self.bits[i] != 0 {
                return i * 64 + (63 - self.bits[i].leading_zeros() as usize);
            }
        }
        0
    }
}