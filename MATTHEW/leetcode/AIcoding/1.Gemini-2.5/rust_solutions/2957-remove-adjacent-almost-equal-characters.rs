struct Solution;

impl Solution {
    pub fn remove_almost_equal_characters(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        if n < 2 {
            return 0;
        }

        let mut removals = 0;
        let mut i = 0;

        while i < n - 1 {
            let char1 = chars[i];
            let char2 = chars[i + 1];

            // Check if char1 and char2 are almost-equal
            if (char1 as i32 - char2 as i32).abs() <= 1 {
                removals += 1;
                // If they are almost-equal, we must remove one.
                // To minimize removals, we conceptually remove chars[i+1].
                // After this removal, chars[i] is now effectively followed by chars[i+2].
                // By advancing `i` by 2, we effectively skip chars[i+1] (which was removed)
                // and also chars[i+2]. This means chars[i] is considered "dealt with"
                // and we start looking for the next problematic pair from chars[i+2] onwards.
                i += 2;
            } else {
                // If they are not almost-equal, char1 and char2 are fine.
                // Move to the next character to form a pair.
                i += 1;
            }
        }

        removals
    }
}