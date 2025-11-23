impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_bytes = s.as_bytes();
        let mut s_double_bytes: Vec<u8> = Vec::with_capacity(2 * n);
        s_double_bytes.extend_from_slice(s_bytes);
        s_double_bytes.extend_from_slice(s_bytes);

        let mut diff0 = 0; // Mismatches for pattern '0101...'
        let mut diff1 = 0; // Mismatches for pattern '1010...'

        // Initial window: s_double_bytes[0...n-1]
        for j in 0..n {
            let expected0 = if j % 2 == 0 { b'0' } else { b'1' };
            let expected1 = if j % 2 == 0 { b'1' } else { b'0' };

            if s_double_bytes[j] != expected0 {
                diff0 += 1;
            }
            if s_double_bytes[j] != expected1 {
                diff1 += 1;
            }
        }

        let mut min_flips = std::cmp::min(diff0, diff1);

        // Slide the window
        // i represents the right end of the current window.
        // The window is s_double_bytes[i-n+1 ... i].
        // The character s_double_bytes[i-n] leaves the window.
        // The character s_double_bytes[i] enters the window.
        for i in n..2 * n {
            let left_char_idx = i - n;

            // Remove s_double_bytes[left_char_idx] from counts
            let char_leaving = s_double_bytes[left_char_idx];
            let expected0_leaving = if left_char_idx % 2 == 0 { b'0' } else { b'1' };
            let expected1_leaving = if left_char_idx % 2 == 0 { b'1' } else { b'0' };

            if char_leaving != expected0_leaving {
                diff0 -= 1;
            }
            if char_leaving != expected1_leaving {
                diff1 -= 1;
            }

            // Add s_double_bytes[i] to counts
            let char_entering = s_double_bytes[i];
            let expected0_entering = if i % 2 == 0 { b'0' } else { b'1' };
            let expected1_entering = if i % 2 == 0 { b'1' } else { b'0' };

            if char_entering != expected0_entering {
                diff0 += 1;
            }
            if char_entering != expected1_entering {
                diff1 += 1;
            }

            min_flips = std::cmp::min(min_flips, diff0);
            min_flips = std::cmp::min(min_flips, diff1);
        }

        min_flips
    }
}