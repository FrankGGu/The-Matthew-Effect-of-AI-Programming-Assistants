use std::collections::BinaryHeap;

impl Solution {
    pub fn remove_stars(s: String) -> String {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut removed = vec![false; n];

        // BinaryHeap in Rust is a max-heap.
        // We store (character, original_index).
        // Tuple comparison is lexicographical: first by char, then by index.
        // This naturally prioritizes:
        // 1. Larger character (e.g., 't' > 'l').
        // 2. For characters of the same value, larger index (e.g., ('e', 2) > ('e', 1)).
        // This exactly matches the problem's removal rules:
        // "remove the lexicographically largest character ... If there are multiple characters with the same largest value, ... remove the one with the largest index (rightmost)."
        let mut heap: BinaryHeap<(char, usize)> = BinaryHeap::new(); 

        for (i, &ch) in s_chars.iter().enumerate() {
            if ch == '*' {
                // When a star is encountered, remove the top element from the heap.
                // This element represents the character to be removed according to the rules.
                if let Some((_, original_index)) = heap.pop() {
                    removed[original_index] = true;
                }
            } else {
                // If it's a character, add it to the heap with its original index.
                heap.push((ch, i));
            }
        }

        // Build the result string by iterating through the original characters.
        // Append characters that are not stars and have not been marked for removal.
        let mut result = String::with_capacity(n);
        for (i, &ch) in s_chars.iter().enumerate() {
            if ch != '*' && !removed[i] {
                result.push(ch);
            }
        }

        result
    }
}