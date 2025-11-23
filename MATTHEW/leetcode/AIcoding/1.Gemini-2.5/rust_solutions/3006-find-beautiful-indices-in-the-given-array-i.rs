impl Solution {
    pub fn find_beautiful_indices(s: String, a: String, b: String, k: i32) -> Vec<i32> {
        let n = s.len();
        let len_a = a.len();
        let len_b = b.len();

        let mut indices_a: Vec<i32> = Vec::new();
        // Find all starting indices of pattern 'a'
        // The problem constraints guarantee a.length <= s.length, so n - len_a will not underflow.
        for i in 0..=n - len_a {
            if s[i..i + len_a] == a {
                indices_a.push(i as i32);
            }
        }

        let mut indices_b: Vec<i32> = Vec::new();
        // Find all starting indices of pattern 'b'
        // The problem constraints guarantee b.length <= s.length, so n - len_b will not underflow.
        for i in 0..=n - len_b {
            if s[i..i + len_b] == b {
                indices_b.push(i as i32);
            }
        }

        let mut beautiful_indices: Vec<i32> = Vec::new();
        let mut ptr_b = 0; // Pointer for iterating through indices_b

        // For each index from 'a', check if there's a corresponding index from 'b'
        for &idx_a in &indices_a {
            let mut found_match = false;

            // Advance ptr_b to the first index in indices_b that is potentially within the range [idx_a - k, idx_a + k].
            // Specifically, we need indices_b[ptr_b] >= idx_a - k.
            while ptr_b < indices_b.len() && indices_b[ptr_b] < idx_a - k {
                ptr_b += 1;
            }

            // Now, check from ptr_b onwards.
            // We need indices_b[current_ptr_b] <= idx_a + k.
            let mut current_ptr_b = ptr_b;
            while current_ptr_b < indices_b.len() && indices_b[current_ptr_b] <= idx_a + k {
                // If we reach this point, then:
                // 1. indices_b[current_ptr_b] >= idx_a - k (due to the first while loop's advancement of ptr_b)
                // 2. indices_b[current_ptr_b] <= idx_a + k (due to the current while loop's condition)
                // These two conditions together mean |idx_a - indices_b[current_ptr_b]| <= k is satisfied.
                found_match = true;
                break; // Found a match for this idx_a, no need to check further idx_b
            }

            if found_match {
                beautiful_indices.push(idx_a);
            }
        }

        // The 'indices_a' vector is naturally sorted, and we iterate through it in order.
        // Thus, 'beautiful_indices' will also be sorted and contain unique values.
        beautiful_indices
    }
}