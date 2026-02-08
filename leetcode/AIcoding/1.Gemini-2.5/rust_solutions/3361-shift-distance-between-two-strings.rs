struct Solution;

impl Solution {
    pub fn shift_distance(s: String, t: String) -> i32 {
        if s.len() != t.len() {
            return -1;
        }

        // If s is empty, t must also be empty due to the length check.
        // An empty string requires 0 shifts to become an empty string.
        // The `find` method on an empty string for an empty pattern returns 0,
        // so no special handling is needed here.

        // Concatenate s with itself to create a string that contains all cyclic shifts of s.
        // For example, if s = "abc", s_doubled = "abcabc".
        // All cyclic shifts ("abc", "bca", "cab") are substrings of "abcabc".
        let s_doubled = s + &s;

        // Find the first occurrence of t within s_doubled.
        // The starting index of t in s_doubled corresponds to the number of left shifts.
        match s_doubled.find(&t) {
            Some(k) => k as i32,
            None => -1, // If t is not found, it's not a cyclic shift of s.
        }
    }
}