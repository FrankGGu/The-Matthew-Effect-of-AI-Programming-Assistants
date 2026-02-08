impl Solution {
    pub fn unique_letter_string(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut prev_pos: Vec<i32> = vec![0; n];
        let mut last_seen: Vec<i32> = vec![-1; 26]; // Stores last seen index for each char, -1 for not seen

        // First pass: calculate prev_pos for each character
        for i in 0..n {
            let char_idx = (s_bytes[i] - b'A') as usize;
            prev_pos[i] = last_seen[char_idx];
            last_seen[char_idx] = i as i32;
        }

        let mut next_pos: Vec<i32> = vec![0; n];
        last_seen.fill(n as i32); // Reset last_seen for next_pos calculation, using n as sentinel

        // Second pass: calculate next_pos for each character (iterating backwards)
        for i in (0..n).rev() {
            let char_idx = (s_bytes[i] - b'A') as usize;
            next_pos[i] = last_seen[char_idx];
            last_seen[char_idx] = i as i32;
        }

        let mut total_sum: i64 = 0; // Use i64 to prevent overflow for intermediate sums

        // Third pass: calculate contributions for each character
        for i in 0..n {
            let left_boundary = prev_pos[i];
            let right_boundary = next_pos[i];

            // Number of choices for the start index 'j' of a substring s[j..k]
            // such that s[i] is unique and j <= i.
            // j must be greater than left_boundary. So, j can be from (left_boundary + 1) to i.
            // Count = i - (left_boundary + 1) + 1 = i - left_boundary.
            let left_count = (i as i32) - left_boundary;

            // Number of choices for the end index 'k' of a substring s[j..k]
            // such that s[i] is unique and k >= i.
            // k must be less than right_boundary. So, k can be from i to (right_boundary - 1).
            // Count = (right_boundary - 1) - i + 1 = right_boundary - i.
            let right_count = right_boundary - (i as i32);

            total_sum += (left_count as i64) * (right_count as i64);
        }

        total_sum as i32 // Cast to i32 for the final return type
    }
}