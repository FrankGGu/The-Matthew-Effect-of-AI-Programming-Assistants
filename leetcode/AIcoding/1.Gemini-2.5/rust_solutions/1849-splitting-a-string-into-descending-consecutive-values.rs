impl Solution {
    pub fn split_string(s: String) -> bool {
        let s_bytes = s.as_bytes();

        // Iterate through all possible first numbers.
        // The first number must leave at least one digit for the subsequent numbers.
        // `i` is the last index of the first number.
        // So `i` can range from `0` up to `s_bytes.len() - 2`.
        // This ensures that `s_bytes[0..=i]` is the first number, and `s_bytes[i+1..]` is non-empty.
        for i in 0..s_bytes.len() - 1 {
            let mut first_num: u64 = 0;
            let mut overflowed_first_num = false;

            // Parse the first number from `s_bytes[0..=i]`.
            for j in 0..=i {
                let digit = (s_bytes[j] - b'0') as u64;

                // Check for potential u64 overflow during parsing.
                // If `first_num` is already large enough that multiplying by 10 or adding `digit`
                // would exceed `u64::MAX`, then this number is too large.
                if first_num > u64::MAX / 10 || (first_num == u64::MAX / 10 && digit > u64::MAX % 10) {
                    overflowed_first_num = true;
                    break;
                }
                first_num = first_num * 10 + digit;
            }

            // If the first number overflowed, it's not a valid starting point. Skip this path.
            if overflowed_first_num {
                continue;
            }

            // Call the recursive helper function (DFS) starting from the next index.
            // `first_num` becomes the `prev_num` for the subsequent numbers.
            if Self::dfs(i + 1, first_num, s_bytes) {
                return true;
            }
        }

        // If no valid split was found after trying all possible first numbers.
        false
    }

    // Helper function for depth-first search (backtracking)
    // `start_index`: The current index in `s_bytes` from which to start parsing the next number.
    // `prev_num`: The numeric value of the number parsed immediately before this call.
    // `s_bytes`: The input string as a byte slice for efficient access.
    fn dfs(start_index: usize, prev_num: u64, s_bytes: &[u8]) -> bool {
        // Base case: If we've reached the end of the string, it means we successfully
        // split the string into valid descending consecutive numbers.
        if start_index == s_bytes.len() {
            return true;
        }

        let mut current_num: u64 = 0;
        // Iterate through possible end points for the current number.
        // `i` is the last index of the current number.
        for i in start_index..s_bytes.len() {
            let digit = (s_bytes[i] - b'0') as u64;

            // Check for potential u64 overflow when constructing `current_num`.
            if current_num > u64::MAX / 10 || (current_num == u64::MAX / 10 && digit > u64::MAX % 10) {
                // This number would overflow u64. It means it's too large.
                // Further extending this substring will also result in overflow or even larger numbers.
                // Since `prev_num` is also `u64`, an overflowing `current_num` cannot be `prev_num - 1`.
                // So, we can stop exploring this path for the current `start_index`.
                break;
            }

            current_num = current_num * 10 + digit;

            // Optimization: If the `current_num` being built is already greater than or equal to `prev_num`,
            // it cannot be `prev_num - 1`. Further extending this substring will only make it larger.
            // So, we can prune this branch.
            if current_num >= prev_num {
                break;
            }

            // Check if the current number is exactly one less than the previous number.
            // `prev_num - 1` handles the case where `prev_num` is 0 by wrapping around to `u64::MAX`.
            // However, `current_num` will always be non-negative. So `current_num == u64::MAX`
            // is only possible if the string itself represents `u64::MAX`.
            // If `prev_num` is 0, `prev_num - 1` is `u64::MAX`. Since `current_num` will be a valid
            // number parsed from the string (max 20 digits), it cannot be `u64::MAX` unless the string
            // is exactly the digits of `u64::MAX`. This implicitly handles the case where `prev_num` is 0
            // and `current_num` cannot be -1.
            if current_num == prev_num - 1 {
                // If a valid number is found, recursively call `dfs` for the rest of the string.
                // If the recursive call returns `true`, then we found a valid split.
                if Self::dfs(i + 1, current_num, s_bytes) {
                    return true;
                }
            }
        }

        // If no valid number could be found from `start_index` that satisfies the condition,
        // or all recursive calls returned `false`, then this path is not valid.
        false
    }
}