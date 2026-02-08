impl Solution {
    pub fn can_alice_win(num: String) -> bool {
        let n = num.len();
        let half_n = n / 2;

        let mut s1 = 0; // Sum of known digits in the first half
        let mut q1 = 0; // Count of '?' in the first half

        let mut s2 = 0; // Sum of known digits in the second half
        let mut q2 = 0; // Count of '?' in the second half

        for (i, char_code) in num.bytes().enumerate() {
            if i < half_n {
                // First half
                if char_code == b'?' {
                    q1 += 1;
                } else {
                    s1 += (char_code - b'0') as i32;
                }
            } else {
                // Second half
                if char_code == b'?' {
                    q2 += 1;
                } else {
                    s2 += (char_code - b'0') as i32;
                }
            }
        }

        // Alice wins if 2 * (s1 - s2) + 9 * (q1 - q2) == 0
        // This formula is derived from the game theory aspect where players try to
        // make the final sum difference zero or non-zero.
        // Each '?' effectively contributes an average of 4.5 to its sum.
        // So, the final difference would be (s1 - s2) + (q1 - q2) * 4.5.
        // Alice wins if this final average difference is 0.
        // (s1 - s2) + (q1 - q2) * 9 / 2 == 0
        // Multiply by 2: 2 * (s1 - s2) + 9 * (q1 - q2) == 0
        (2 * (s1 - s2) + 9 * (q1 - q2)) == 0
    }
}