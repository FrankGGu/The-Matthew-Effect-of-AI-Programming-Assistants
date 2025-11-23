use std::cmp::max;

impl Solution {
    pub fn take_characters(s: String, k: i32) -> i32 {
        let n = s.len() as i32;

        // Step 1: Calculate total counts of 'a', 'b', 'c' in the entire string.
        let mut total_counts = [0; 3]; // [count_a, count_b, count_c]
        for c in s.bytes() {
            total_counts[(c - b'a') as usize] += 1;
        }

        // Step 2: Determine the maximum allowed counts for each character in the "middle" segment.
        // The problem asks to minimize characters taken from ends such that the taken characters
        // (prefix + suffix) have at least `k` of each.
        // This is equivalent to finding the longest "middle" segment `s[left..right]`
        // such that the characters *not* in this middle segment (i.e., `s[0..left]` and `s[right..n]`)
        // satisfy the `k` condition.
        //
        // Let `taken_char_count[x]` be the count of character `x` in the taken parts.
        // We need `taken_char_count[x] >= k`.
        // Also, `taken_char_count[x] = total_counts[x] - middle_char_count[x]`.
        // So, `total_counts[x] - middle_char_count[x] >= k`.
        // Rearranging, `middle_char_count[x] <= total_counts[x] - k`.
        //
        // If `total_counts[x] - k` is negative, it means even if we take all occurrences of `x`
        // from the ends, we still don't have `k` of `x`. In this case, the middle segment
        // must not contain any `x` (i.e., `middle_char_count[x]` must be 0).
        // The `max(0, ...)` handles this: `middle_char_count[x] <= max(0, total_counts[x] - k)`.
        let mut target_counts = [0; 3];
        for i in 0..3 {
            target_counts[i] = max(0, total_counts[i] - k);
        }

        // Step 3: Use a sliding window to find the longest substring `s[left..right]`
        // (the "middle" segment) that satisfies `current_counts[i] <= target_counts[i]` for all i.
        let mut max_middle_len = 0;
        let mut left = 0;
        let mut current_counts = [0; 3]; // Counts for the current window s[left..right]
        let s_bytes = s.as_bytes();

        for right in 0..n {
            let char_idx = (s_bytes[right as usize] - b'a') as usize;
            current_counts[char_idx] += 1;

            // Shrink the window from the left if any character count exceeds its target.
            while current_counts[0] > target_counts[0] ||
                  current_counts[1] > target_counts[1] ||
                  current_counts[2] > target_counts[2] {

                let left_char_idx = (s_bytes[left as usize] - b'a') as usize;
                current_counts[left_char_idx] -= 1;
                left += 1;
            }

            // After shrinking, the current window `s[left..right]` is valid.
            // Update the maximum length of such a valid middle segment.
            max_middle_len = max(max_middle_len, right - left + 1);
        }

        // The minimum number of characters to take from the ends is the total length `n`
        // minus the length of the longest valid middle segment.
        n - max_middle_len
    }
}