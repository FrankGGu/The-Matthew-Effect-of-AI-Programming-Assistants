impl Solution {
    pub fn orderly_queue(s: String, k: i32) -> String {
        if k == 1 {
            let n = s.len();
            let mut min_s = s.clone();
            let mut current_chars: Vec<char> = s.chars().collect();

            for _ in 0..n {
                // Perform one rotation: take the first character and append it to the end
                let first_char = current_chars.remove(0);
                current_chars.push(first_char);

                let rotated_s: String = current_chars.iter().collect();
                if rotated_s < min_s {
                    min_s = rotated_s;
                }
            }
            min_s
        } else {
            // If k > 1, we can achieve any permutation of the string.
            // Therefore, the lexicographically smallest string is the sorted version of the original string.
            let mut s_chars: Vec<char> = s.chars().collect();
            s_chars.sort_unstable();
            s_chars.into_iter().collect()
        }
    }
}