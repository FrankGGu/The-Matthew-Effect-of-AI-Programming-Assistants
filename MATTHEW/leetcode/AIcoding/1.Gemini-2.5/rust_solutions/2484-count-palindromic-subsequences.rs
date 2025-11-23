impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        // next_char_pos[i][d] stores the index of the first occurrence of digit 'd' at or after index i.
        // If digit 'd' is not found at or after index i, it stores n.
        let mut next_char_pos = vec![vec![n; 10]; n + 1];
        for i in (0..n).rev() {
            for d in 0..10 {
                next_char_pos[i][d] = next_char_pos[i + 1][d];
            }
            let current_digit = (s_bytes[i] - b'0') as usize;
            next_char_pos[i][current_digit] = i;
        }

        let mut ans = 0;

        // Iterate through all possible combinations of digits x, y, z (0-9)
        // A palindromic subsequence of length 5 has the form "xyzyx".
        for x in 0..10 {
            for y in 0..10 {
                for z in 0..10 {
                    // Find the first occurrence of 'x'
                    let x_idx1 = next_char_pos[0][x];
                    if x_idx1 == n {
                        continue; // No 'x' found in the string
                    }

                    // Find the first occurrence of 'y' strictly after x_idx1
                    let y_idx1 = next_char_pos[x_idx1 + 1][y];
                    if y_idx1 == n {
                        continue; // No 'y' found after x_idx1
                    }

                    // Find the first occurrence of 'z' strictly after y_idx1
                    let z_idx = next_char_pos[y_idx1 + 1][z];
                    if z_idx == n {
                        continue; // No 'z' found after y_idx1
                    }

                    // Find the second occurrence of 'y' strictly after z_idx
                    let y_idx2 = next_char_pos[z_idx + 1][y];
                    if y_idx2 == n {
                        continue; // No second 'y' found after z_idx
                    }

                    // Find the second occurrence of 'x' strictly after y_idx2
                    let x_idx2 = next_char_pos[y_idx2 + 1][x];
                    if x_idx2 == n {
                        continue; // No second 'x' found after y_idx2
                    }

                    // If all five characters are found in the correct order,
                    // we have successfully formed a distinct palindromic subsequence "xyzyx".
                    ans += 1;
                }
            }
        }

        ans
    }
}