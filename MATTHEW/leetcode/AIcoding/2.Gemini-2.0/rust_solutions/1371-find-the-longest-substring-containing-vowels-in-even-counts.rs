impl Solution {
    pub fn find_the_longest_substring(s: String) -> i32 {
        let mut state = 0;
        let mut first = vec![s.len() as i32; 32];
        first[0] = -1;
        let mut max_len = 0;

        for (i, c) in s.chars().enumerate() {
            match c {
                'a' => state ^= 1,
                'e' => state ^= 2,
                'i' => state ^= 4,
                'o' => state ^= 8,
                'u' => state ^= 16,
                _ => (),
            }

            if first[state] == s.len() as i32 {
                first[state] = i as i32;
            }

            max_len = max_len.max(i as i32 - first[state]);
        }

        max_len
    }
}