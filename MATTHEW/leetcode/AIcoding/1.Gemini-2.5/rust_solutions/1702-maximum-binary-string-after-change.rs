impl Solution {
    pub fn maximum_binary_string(binary: String) -> String {
        let n = binary.len();
        let mut chars: Vec<char> = binary.chars().collect();

        let mut first_zero_idx: Option<usize> = None;
        let mut num_zeros = 0;

        for (i, &c) in chars.iter().enumerate() {
            if c == '0' {
                if first_zero_idx.is_none() {
                    first_zero_idx = Some(i);
                }
                num_zeros += 1;
            }
        }

        if num_zeros == 0 {
            // If there are no zeros, the string is already all '1's, which is the maximum.
            return binary;
        }

        if num_zeros == 1 {
            // If there is only one '0', the "00" -> "10" operation cannot be applied.
            // The "10" -> "01" operation moves a '0' to the left past a '1'.
            // This means the single '0' can be moved to the very first position.
            // Example: "11011" -> "10111" -> "01111".
            // The lexicographically largest string will be "0" followed by N-1 "1"s.
            let mut result_chars = vec!['1'; n];
            result_chars[0] = '0';
            return result_chars.into_iter().collect();
        }

        // If num_zeros > 1:
        // The "10" -> "01" operation moves a '0' to the left past a '1'.
        // This means all '0's can be consolidated into a contiguous block.
        // This block will start at the position of the first '0' in the original string (`first_zero_idx`).
        // Example: "110101" (first_zero_idx=2, num_zeros=2)
        // By repeatedly applying "10" -> "01", the '0' at index 4 can be moved to index 3: "110011".
        // Now we have a contiguous block of '0's: "00" at indices 2,3.
        //
        // The "00" -> "10" operation can be applied `num_zeros - 1` times to this contiguous block.
        // Each application converts the leftmost '0' in a "00" pair to a '1',
        // effectively moving the remaining '0' one position to the right within the block.
        // Example: "000" -> "100" -> "110". The final '0' ends up at the rightmost position of the original block.
        //
        // So, the final string will have `N-1` ones and one '0'.
        // The position of this single '0' will be `first_zero_idx + (num_zeros - 1)`.

        let mut result_chars = vec!['1'; n];
        let zero_position = first_zero_idx.unwrap() + (num_zeros - 1);
        result_chars[zero_position] = '0';

        result_chars.into_iter().collect()
    }
}