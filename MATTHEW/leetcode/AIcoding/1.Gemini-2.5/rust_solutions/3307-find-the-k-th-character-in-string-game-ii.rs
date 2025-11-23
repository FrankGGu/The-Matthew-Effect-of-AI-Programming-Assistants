impl Solution {
    pub fn find_kth_bit(n: i32, k: i32) -> char {
        let mut current_n = n;
        let mut current_k = k;
        let mut inverted_state = false;

        while current_n > 1 {
            let len_prev = (1 << (current_n - 1)) - 1;
            let mid_idx = len_prev + 1;

            if current_k == mid_idx {
                return if inverted_state { '0' } else { '1' };
            } else if current_k < mid_idx {
                current_n -= 1;
            } else {
                current_k = len_prev - (current_k - mid_idx) + 1;
                inverted_state = !inverted_state;
                current_n -= 1;
            }
        }

        if inverted_state { '1' } else { '0' }
    }
}