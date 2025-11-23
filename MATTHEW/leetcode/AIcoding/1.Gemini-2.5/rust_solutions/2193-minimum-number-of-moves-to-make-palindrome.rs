impl Solution {
    pub fn min_moves_to_make_palindrome(s: String) -> i32 {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() - 1;
        let mut moves = 0;

        while left < right {
            if chars[left] == chars[right] {
                left += 1;
                right -= 1;
            } else {
                // Find the rightmost character matching chars[left] in the range [left+1, right]
                let mut k = right;
                while k > left && chars[k] != chars[left] {
                    k -= 1;
                }

                if k == left {
                    // If k == left, it means chars[left] has no match in the [left+1, right] segment.
                    // This implies chars[left] must be the unique middle character of the palindrome.
                    // We move it to the center of the current [left, right] segment.
                    // The number of swaps needed is (right - left) / 2.
                    moves += (right - left) / 2;

                    // Conceptually remove this character, as it's now in its final middle position.
                    // The string effectively shortens, so 'right' must be decremented.
                    chars.remove(left);
                    right -= 1;

                    // 'left' does not increment because the character that was at 'left+1'
                    // has now shifted to 'left', and it needs to be processed in the next iteration.
                } else {
                    // Found a match at index k for chars[left].
                    // Move chars[k] to chars[right].
                    // The number of adjacent swaps required is (right - k).
                    moves += (right - k);

                    // Simulate the move: remove chars[k] and insert it at chars[right].
                    // This operation correctly reflects the cost of adjacent swaps.
                    let char_to_move = chars.remove(k);
                    chars.insert(right, char_to_move);

                    // Now chars[left] and chars[right] match.
                    // Advance both pointers to process the next pair.
                    left += 1;
                    right -= 1;
                }
            }
        }

        moves
    }
}