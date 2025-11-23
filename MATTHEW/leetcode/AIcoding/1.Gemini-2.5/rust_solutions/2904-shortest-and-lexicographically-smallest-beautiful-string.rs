struct Solution;

impl Solution {
    pub fn shortest_beautiful_string(s: String, k: i32) -> String {
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();
        let k_usize = k as usize;

        // next_occurrence[digit][i] stores the smallest index j >= i such that s_chars[j] == digit.
        // If no such j exists, it stores n.
        let mut next_occurrence: Vec<Vec<usize>> = vec![vec![n; n + 1]; 10];

        for digit in 1..=9 {
            let char_digit = std::char::from_digit(digit as u32, 10).unwrap();
            let mut last_idx = n; // Default: not found
            for i in (0..n).rev() {
                if s_chars[i] == char_digit {
                    last_idx = i;
                }
                next_occurrence[digit][i] = last_idx;
            }
        }

        // Memoization tables:
        // memo_char[pos][last_d][mask] stores the char ('1'-'9') chosen for the current position.
        // memo_s_idx[pos][last_d][mask] stores the index in s_chars where memo_char was found.
        // visited[pos][last_d][mask] tracks if a state has been computed to avoid redundant work.
        let mut memo_char: Vec<Vec<Vec<Option<char>>>> =
            vec![vec![vec![None; 1 << 10]; 10]; k_usize];
        let mut memo_s_idx: Vec<Vec<Vec<Option<usize>>>> =
            vec![vec![vec![None; 1 << 10]; 10]; k_usize];
        let mut visited: Vec<Vec<Vec<bool>>> = vec![vec![vec![false; 1 << 10]; 10]; k_usize];

        // dfs(pos, last_d, mask, current_s_idx)
        // pos: current position (0 to k-1) in the beautiful string being built.
        // last_d: value of the digit placed at pos-1 (0 if pos == 0).
        // mask: bitmask of digits used so far in the beautiful string.
        // current_s_idx: minimum index in s_chars from which the current digit can be picked.
        // Returns true if a beautiful string can be formed from this state, false otherwise.
        fn dfs(
            pos: usize,
            last_d: u8,
            mask: u16,
            current_s_idx: usize,
            s_chars: &[char],
            k_usize: usize,
            n: usize,
            next_occurrence: &[Vec<usize>],
            memo_char: &mut [Vec<Vec<Option<char>>>],
            memo_s_idx: &mut [Vec<Vec<Option<usize>>>],
            visited: &mut [Vec<Vec<bool>>],
        ) -> bool {
            if pos == k_usize {
                return true; // Beautiful string of length k found
            }

            if visited[pos][last_d as usize][mask as usize] {
                return memo_char[pos][last_d as usize][mask as usize].is_some();
            }

            visited[pos][last_d as usize][mask as usize] = true;

            // Try digits '1' through '9' for the current position to ensure lexicographical smallest
            for d_val in 1..=9 {
                // Check unique digit rule
                if (mask >> d_val) & 1 == 1 {
                    continue; // Digit already used
                }

                // Check divisibility rule (if not the first digit)
                if pos > 0 && d_val % last_d != 0 {
                    continue;
                }

                // Find the earliest occurrence of d_val in s_chars from current_s_idx
                let next_s_pos = next_occurrence[d_val as usize][current_s_idx];

                if next_s_pos < n {
                    // If digit d_val is found in s_chars
                    let new_mask = mask | (1 << d_val);
                    if dfs(
                        pos + 1,
                        d_val,
                        new_mask,
                        next_s_pos + 1, // Next digit must be picked after this one
                        s_chars,
                        k_usize,
                        n,
                        next_occurrence,
                        memo_char,
                        memo_s_idx,
                        visited,
                    ) {
                        // If a solution is found, store this choice
                        memo_char[pos][last_d as usize][mask as usize] =
                            Some(std::char::from_digit(d_val as u32, 10).unwrap());
                        memo_s_idx[pos][last_d as usize][mask as usize] = Some(next_s_pos);
                        return true; // Found the lexicographically smallest choice for this state
                    }
                }
            }
            false // No beautiful string can be formed from this state
        }

        // Start the DFS from the initial state
        if !dfs(
            0, // pos: starting at the first position
            0, // last_d: 0 indicates no previous digit
            0, // mask: no digits used yet
            0, // current_s_idx: start searching from the beginning of s
            &s_chars,
            k_usize,
            n,
            &next_occurrence,
            &mut memo_char,
            &mut memo_s_idx,
            &mut visited,
        ) {
            return String::new(); // No beautiful string found
        }

        // Reconstruct the beautiful string by following the memoized choices
        let mut result = String::with_capacity(k_usize);
        let mut current_pos = 0;
        let mut current_last_d = 0;
        let mut current_mask = 0;
        let mut current_s_idx = 0;

        while current_pos < k_usize {
            let chosen_char = memo_char[current_pos][current_last_d as usize][current_mask as usize]
                .unwrap();
            let chosen_s_idx = memo_s_idx[current_pos][current_last_d as usize][current_mask as usize]
                .unwrap();

            result.push(chosen_char);

            current_last_d = chosen_char.to_digit(10).unwrap() as u8;
            current_mask |= 1 << current_last_d;
            current_s_idx = chosen_s_idx + 1;
            current_pos += 1;
        }

        result
    }
}