impl Solution {
    pub fn find_longest_balanced_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut num_zeros = 0;
        let mut num_ones = 0;

        for c in s.chars() {
            if c == '0' {
                if num_ones > 0 {
                    // If we encounter a '0' after counting some '1's,
                    // it means the previous '0...01...1' sequence has ended.
                    // We reset 'num_ones' and start a new count for '0's.
                    num_zeros = 1;
                    num_ones = 0;
                } else {
                    // Continue counting consecutive '0's.
                    num_zeros += 1;
                }
            } else { // c == '1'
                if num_zeros > 0 {
                    // If we have counted some '0's, this '1' can extend the sequence.
                    num_ones += 1;
                    // Update max_len with the current balanced substring length.
                    // The length is twice the minimum of consecutive '0's and '1's.
                    max_len = max_len.max(num_zeros.min(num_ones) * 2);
                } else {
                    // If a '1' is encountered without any preceding '0's in the current segment,
                    // it cannot form a balanced substring of the required type.
                    // Reset both counts.
                    num_zeros = 0;
                    num_ones = 0;
                }
            }
        }

        max_len
    }
}