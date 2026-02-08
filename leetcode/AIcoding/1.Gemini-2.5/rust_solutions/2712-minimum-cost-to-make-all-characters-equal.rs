impl Solution {
    pub fn minimum_cost(s: String) -> i64 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        // Calculate cost if we initially aim to make all characters '0'
        let mut cost_to_make_all_zero: i64 = 0;
        let mut current_target_is_one_effective: i32 = 0; // 0 means current segment target is '0', 1 means current segment target is '1'
        for i in 0..n {
            let char_val = (chars[i] as u8 - b'0') as i32;

            // If the current character's value does not match the current effective target
            if char_val != current_target_is_one_effective {
                // We must perform an operation at index i.
                // Both operations (flip s[i] or flip s[i...n-1]) cost i+1.
                // To maintain the "all characters equal" property efficiently,
                // we choose to flip s[i...n-1]. This makes s[i] consistent
                // and also flips the effective target for subsequent characters.
                cost_to_make_all_zero += (i + 1) as i64;
                current_target_is_one_effective = 1 - current_target_is_one_effective; // Toggle the effective target for the next character
            }
        }

        // Calculate cost if we initially aim to make all characters '1'
        let mut cost_to_make_all_one: i64 = 0;
        let mut current_target_is_one_effective_for_one: i32 = 1; // 0 means current segment target is '0', 1 means current segment target is '1'
        for i in 0..n {
            let char_val = (chars[i] as u8 - b'0') as i32;

            // If the current character's value does not match the current effective target
            if char_val != current_target_is_one_effective_for_one {
                cost_to_make_all_one += (i + 1) as i64;
                current_target_is_one_effective_for_one = 1 - current_target_is_one_effective_for_one;
            }
        }

        // The minimum cost is the minimum of making all characters '0' or making all characters '1'
        cost_to_make_all_zero.min(cost_to_make_all_one)
    }
}