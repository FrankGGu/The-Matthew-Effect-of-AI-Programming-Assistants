impl Solution {
    pub fn find_the_longest_substring(s: String) -> i32 {
        let mut mask = 0;
        let mut first_occurrence = vec![-1; 32];
        first_occurrence[0] = 0;
        let mut max_len = 0;
        let vowels = ['a', 'e', 'i', 'o', 'u'];

        for (i, c) in s.chars().enumerate() {
            if let Some(pos) = vowels.iter().position(|&v| v == c) {
                mask ^= 1 << pos;
            }
            if first_occurrence[mask as usize] == -1 {
                first_occurrence[mask as usize] = (i + 1) as i32;
            } else {
                max_len = max_len.max((i + 1) as i32 - first_occurrence[mask as usize]);
            }
        }
        max_len
    }
}