impl Solution {
    pub fn decode_ciphertext(ciphertext: String, rows: i32) -> String {
        let n = ciphertext.len();
        if n == 0 {
            return String::new();
        }

        let rows_usize = rows as usize;

        // Step 1: Determine 'cols' by solving the equation:
        // n = sum_{j=0}^{cols-1} min(rows, cols - j)
        // This sum represents the total length of the ciphertext formed by reading 'cols' diagonals.
        // The function f(c_val) = sum_{k=1}^{c_val} min(rows, k) calculates this sum for a given c_val (number of columns).
        // This function is strictly increasing, so binary search can be used to find 'cols'.
        //
        // f(c_val) can be calculated in O(1):
        // If c_val <= rows: f(c_val) = c_val * (c_val + 1) / 2
        // If c_val > rows: f(c_val) = rows * (rows + 1) / 2 + (c_val - rows) * rows

        let mut low = 1;
        let mut high = n as i32; // Maximum possible cols is n (when rows=1)
        let mut cols = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if mid == 0 { // cols must be at least 1
                low = 1;
                continue;
            }

            let current_len = if mid <= rows {
                mid * (mid + 1) / 2
            } else {
                rows * (rows + 1) / 2 + (mid - rows) * rows
            };

            if current_len == n as i32 {
                cols = mid;
                break;
            } else if current_len < n as i32 {
                low = mid + 1;
            } else { // current_len > n as i32
                high = mid - 1;
            }
        }

        let cols_usize = cols as usize;
        let mut grid_flat: Vec<char> = vec![' '; rows_usize * cols_usize];
        let ciphertext_chars: Vec<char> = ciphertext.chars().collect();
        let mut cipher_idx = 0;

        // Step 2: Fill the grid diagonally with ciphertext characters
        // Iterate through starting columns of diagonals (j from 0 to cols-1)
        for j in 0..cols_usize {
            // Iterate through characters in the current diagonal (i from 0 to rows-1)
            for i in 0..rows_usize {
                let r = i;
                let c = j + i;
                if c < cols_usize { // If the column index is within grid bounds
                    // Since 'cols' was derived such that sum of diagonal lengths equals 'n',
                    // 'cipher_idx' will naturally go up to 'n-1' when filling.
                    grid_flat[r * cols_usize + c] = ciphertext_chars[cipher_idx];
                    cipher_idx += 1;
                } else {
                    // This diagonal element is out of bounds for the current diagonal.
                    // The current diagonal has ended, move to the next starting column 'j'.
                    break;
                }
            }
        }

        // Step 3: Read the grid row by row to get the original text
        let mut decoded_text_chars: Vec<char> = Vec::with_capacity(rows_usize * cols_usize);
        for r in 0..rows_usize {
            for c in 0..cols_usize {
                decoded_text_chars.push(grid_flat[r * cols_usize + c]);
            }
        }

        // Step 4: Remove any trailing spaces from the decoded text
        while let Some(&' ') = decoded_text_chars.last() {
            decoded_text_chars.pop();
        }

        decoded_text_chars.into_iter().collect()
    }
}