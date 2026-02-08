use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut counts = vec![vec![0; 26]; 26]; // counts[c1_idx][c2_idx]

        for word in words {
            let chars: Vec<char> = word.chars().collect();
            let c1_idx = (chars[0] as u8 - b'a') as usize;
            let c2_idx = (chars[1] as u8 - b'a') as usize;
            counts[c1_idx][c2_idx] += 1;
        }

        let mut total_length = 0;
        let mut has_odd_palindromic_center = false;

        for i in 0..26 {
            for j in 0..26 {
                if counts[i][j] == 0 {
                    continue;
                }

                if i == j { // Palindromic word like "aa"
                    total_length += (counts[i][i] / 2) * 4;
                    if counts[i][i] % 2 == 1 {
                        has_odd_palindromic_center = true;
                    }
                    counts[i][i] = 0; // Mark as processed
                } else if i < j { // Non-palindromic word like "ab" (where 'a' < 'b')
                    // We need to pair counts[i][j] with counts[j][i]
                    let pairs = counts[i][j].min(counts[j][i]);
                    total_length += pairs * 4;
                    counts[i][j] = 0; // Mark as processed
                    counts[j][i] = 0; // Mark as processed
                }
                // If i > j, counts[i][j] would have been processed when we encountered counts[j][i]
                // (e.g., "ba" processed when "ab" was processed). So we do nothing here.
            }
        }

        if has_odd_palindromic_center {
            total_length += 2;
        }

        total_length
    }
}