impl Solution {
    pub fn find_kth_character(n: i32, k: i32) -> char {
        if n == 0 {
            return '0';
        }

        let mid_idx = 1 << n; // Represents 2^n

        if k == mid_idx {
            '1'
        } else if k < mid_idx {
            Self::find_kth_character(n - 1, k)
        } else {
            let k_in_reversed_part = k - mid_idx;
            let original_k_in_prev_string = (1 << n) - k_in_reversed_part;

            let char_in_prev_string = Self::find_kth_character(n - 1, original_k_in_prev_string);

            if char_in_prev_string == '0' {
                '1'
            } else {
                '0'
            }
        }
    }
}