impl Solution {
    pub fn make_strings_equal(s: String, target: String) -> bool {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let target_bytes = target.as_bytes();

        let mut s_ones = 0;
        let mut target_ones = 0;

        for k in 0..n {
            if s_bytes[k] == b'1' {
                s_ones += 1;
            }
            if target_bytes[k] == b'1' {
                target_ones += 1;
            }
            // If target has a '1' at an index where s has a '0',
            // it's impossible to make them equal because the operation
            // can only change '1's to '0's, never '0's to '1's.
            if target_bytes[k] == b'1' && s_bytes[k] == b'0' {
                return false;
            }
        }

        // Case 1: Target string is all '0's.
        if target_ones == 0 {
            // 's' must also become all '0's.
            // The operation '11' -> '00' reduces the count of '1's by 2.
            // To make 's' all '0's, the initial count of '1's in 's' must be even.
            // (If s_ones is 0, it's already all '0's, and 0 is even.
            // If s_ones is >= 2 and even, we can repeatedly apply the operation until all '1's are gone).
            // If s_ones is odd, we will always be left with one '1', which cannot be removed.
            return s_ones % 2 == 0;
        }

        // Case 2: Target string has at least one '1'.
        // We have already ensured that for any '1' in target, there is a '1' in s (from the initial loop check).
        // This means s_ones must be greater than or equal to target_ones.
        // We need to eliminate (s_ones - target_ones) '1's from 's'.
        // Since each operation removes two '1's, the difference (s_ones - target_ones) must be an even number.
        // If (s_ones - target_ones) is 0, then s == target, and it's possible.
        // If (s_ones - target_ones) is a positive even number, we can perform (s_ones - target_ones) / 2 operations.
        // Since target_ones >= 1, it means s_ones >= 1.
        // We can always find two '1's to operate on: either two '1's that are part of the 'extra' ones,
        // or one 'extra' '1' and one '1' that is also in 'target' (which we can then restore if needed, but the problem implies we just need to reach the state).
        // The key is that if target_ones >= 1 and s_ones >= target_ones, we always have '1's available to perform operations to reduce the 'extra' '1's.
        (s_ones - target_ones) % 2 == 0
    }
}