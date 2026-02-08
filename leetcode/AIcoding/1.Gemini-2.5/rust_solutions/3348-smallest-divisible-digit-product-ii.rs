use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn smallest_divisible_digit_product_ii(n: i32) -> String {
        let n_usize = n as usize;
        // memo[remainder] stores (previous_remainder, digit_used_to_reach_current_remainder)
        // -1 for previous_remainder indicates a starting digit.
        let mut memo: Vec<Option<(i32, i32)>> = vec![None; n_usize];
        let mut q: VecDeque<i32> = VecDeque::new();

        // Initialize BFS with single digits 1-9.
        // Numbers cannot start with 0.
        for d in 1..=9 {
            let rem = d % n;
            if memo[rem as usize].is_none() {
                memo[rem as usize] = Some((-1, d)); // -1 indicates a starting digit
                q.push_back(rem);
            }
        }

        while let Some(current_rem) = q.pop_front() {
            // If current_rem is 0, we found the smallest number (shortest length, then lexicographically smallest)
            // because BFS explores layer by layer (shortest length first) and we try digits 0-9 in order.
            if current_rem == 0 {
                // Reconstruct the number by backtracking from remainder 0
                let mut result_digits = Vec::new();
                let mut r = current_rem;
                loop {
                    let (prev_r, digit) = memo[r as usize].unwrap();
                    result_digits.push(digit);
                    if prev_r == -1 {
                        break;
                    }
                    r = prev_r;
                }
                // Digits are collected in reverse order, so reverse them to get the correct number string
                return result_digits.into_iter().rev().map(|d| d.to_string()).collect();
            }

            // Explore adding digits 0-9 to form new numbers
            for d in 0..=9 {
                let next_rem = (current_rem * 10 + d) % n;

                // If this remainder hasn't been visited yet, or we found a shorter/lexicographically smaller path
                // (which is implicitly handled by BFS and digit iteration order)
                if memo[next_rem as usize].is_none() {
                    memo[next_rem as usize] = Some((current_rem, d));
                    q.push_back(next_rem);
                }
            }
        }

        // According to problem constraints and typical LeetCode problems, a solution is always guaranteed.
        // This line should theoretically not be reached.
        unreachable!();
    }
}