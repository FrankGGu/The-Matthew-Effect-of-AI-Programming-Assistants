impl Solution {
    pub fn is_match(s1: String, s2: String) -> bool {
        let s1_chars = s1.as_bytes();
        let s2_chars = s2.as_bytes();

        // Memoization table: memo[i][j][diff + OFFSET]
        // i: index for s1 (0 to s1.len(), max 40 -> 41 states)
        // j: index for s2 (0 to s2.len(), max 40 -> 41 states)
        // diff: s1_processed_count - s2_processed_count. Max diff can be 999 (e.g., "999" vs "a"), min -999.
        // Range [-999, 999] means 1999 possible values. Offset by 999 to get [0, 1998].
        const DIFF_OFFSET: i32 = 999;
        let mut memo = vec![vec![vec![None; (DIFF_OFFSET * 2 + 1) as usize]; 41]; 41];

        Self::dfs(0, 0, 0, s1_chars, s2_chars, &mut memo, DIFF_OFFSET)
    }

    fn dfs(
        i: usize,
        j: usize,
        diff: i32, // s1_processed_count - s2_processed_count
        s1_chars: &[u8],
        s2_chars: &[u8],
        memo: &mut Vec<Vec<Vec<Option<bool>>>>,
        diff_offset: i32,
    ) -> bool {
        // Base case: Both strings exhausted
        if i == s1_chars.len() && j == s2_chars.len() {
            return diff == 0;
        }

        // Memoization check
        let diff_idx = (diff + diff_offset) as usize;
        if let Some(res) = memo[i][j][diff_idx] {
            return res;
        }

        let mut ans = false;

        // Try advancing s1
        if i < s1_chars.len() {
            let c1 = s1_chars[i];
            if c1.is_ascii_digit() {
                // Parse the maximal number (1 to 3 digits, 1-999)
                let (num_val, next_i) = Self::parse_num(s1_chars, i);
                // If num_val is 0, it means an invalid number like "0" or "01" was encountered.
                // This path is not valid, so `ans` remains false.
                if num_val > 0 {
                    ans = ans || Self::dfs(next_i, j, diff + num_val, s1_chars, s2_chars, memo, diff_offset);
                }
            } else { // s1[i] is a letter
                if diff == 0 {
                    // If diff is 0, s1 consumes 1 char, increasing diff to 1.
                    ans = ans || Self::dfs(i + 1, j, 1, s1_chars, s2_chars, memo, diff_offset);
                } else {
                    // If diff != 0, s1 consumes 1 char, reducing the absolute diff.
                    // If diff > 0, s1 was ahead, now less ahead (diff-1).
                    // If diff < 0, s2 was ahead, now less ahead (diff+1).
                    ans = ans || Self::dfs(i + 1, j, diff - diff.signum(), s1_chars, s2_chars, memo, diff_offset);
                }
            }
        }

        // If a solution is already found by advancing s1, we don't need to try advancing s2 from this state.
        // This is an optimization.
        if ans {
            memo[i][j][diff_idx] = Some(true);
            return true;
        }

        // Try advancing s2
        if j < s2_chars.len() {
            let c2 = s2_chars[j];
            if c2.is_ascii_digit() {
                // Parse the maximal number (1 to 3 digits, 1-999)
                let (num_val, next_j) = Self::parse_num(s2_chars, j);
                // If num_val is 0, it means an invalid number like "0" or "01" was encountered.
                // This path is not valid, so `ans` remains false.
                if num_val > 0 {
                    ans = ans || Self::dfs(i, next_j, diff - num_val, s1_chars, s2_chars, memo, diff_offset);
                }
            } else { // s2[j] is a letter
                if diff == 0 {
                    // If diff is 0, s2 consumes 1 char, decreasing diff to -1.
                    ans = ans || Self::dfs(i, j + 1, -1, s1_chars, s2_chars, memo, diff_offset);
                } else {
                    // If diff != 0, s2 consumes 1 char, reducing the absolute diff.
                    // If diff > 0, s1 was ahead, s2 catches up (diff-1).
                    // If diff < 0, s2 was ahead, now more ahead (diff+1).
                    ans = ans || Self::dfs(i, j + 1, diff + diff.signum(), s1_chars, s2_chars, memo, diff_offset);
                }
            }
        }

        memo[i][j][diff_idx] = Some(ans);
        ans
    }

    // Helper to parse the maximal number (1-999) starting at `start_idx`.
    // Returns (number_value, next_index).
    // Returns (0, start_idx) if an invalid number (e.g., "0" or "01") is found.
    fn parse_num(s_chars: &[u8], start_idx: usize) -> (i32, usize) {
        if s_chars[start_idx] == b'0' {
            return (0, start_idx); // Invalid number "0" or "01" (if next digit exists)
        }

        let mut num = 0;
        let mut k = start_idx;
        while k < s_chars.len() && s_chars[k].is_ascii_digit() {
            let digit = (s_chars[k] - b'0') as i32;
            let next_num = num * 10 + digit;
            if next_num > 999 { // Number exceeds 999, stop parsing
                break;
            }
            num = next_num;
            k += 1;
        }
        (num, k)
    }
}