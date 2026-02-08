use std::collections::VecDeque;

impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let n = s.len();
        if n == 0 {
            return true;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        // 1. Anagram check: ensure s and t have the same character counts
        let mut s_counts = [0; 10];
        let mut t_counts = [0; 10];

        for i in 0..n {
            s_counts[(s_chars[i] as u8 - b'0') as usize] += 1;
            t_counts[(t_chars[i] as u8 - b'0') as usize] += 1;
        }

        if s_counts != t_counts {
            return false;
        }

        // 2. Populate queues with indices of each digit in s
        // queues[digit] stores a VecDeque of original indices where 'digit' appears in s.
        // Indices are stored in increasing order.
        let mut queues: Vec<VecDeque<usize>> = vec![VecDeque::new(); 10];
        for i in 0..n {
            queues[(s_chars[i] as u8 - b'0') as usize].push_back(i);
        }

        // 3. Process t from left to right
        // For each character t[j], we try to find its corresponding character in s
        // and check if it can be moved to the current effective position.
        for j in 0..n {
            let target_digit = (t_chars[j] as u8 - b'0') as usize;

            // Get the original index of the leftmost available occurrence of target_digit in s.
            // The unwrap is safe because the anagram check guarantees that there will be
            // an available character for each t[j].
            let s_idx = *queues[target_digit].front().unwrap();

            // Constraint check: A character X can never move to the left past a character Y if X > Y.
            // This means if we want to move s[s_idx] (which is target_digit) to the current
            // position, there must not be any available character s[k] such that k < s_idx
            // and s[k] < target_digit.
            for d in 0..target_digit {
                if let Some(&first_idx_of_smaller_digit) = queues[d].front() {
                    if first_idx_of_smaller_digit < s_idx {
                        // Found a smaller digit 'd' at an index 'first_idx_of_smaller_digit'
                        // which is to the left of 's_idx'.
                        // 'target_digit' (s[s_idx]) cannot move past 'd' (s[first_idx_of_smaller_digit])
                        // because target_digit > d. Thus, transformation is impossible.
                        return false;
                    }
                }
            }

            // If the loop completes, it means s[s_idx] can be moved to the current position.
            // Consume this character by removing its index from the queue.
            queues[target_digit].pop_front();
        }

        // If all characters in t have been successfully matched and moved, return true.
        true
    }
}