impl Solution {
    pub fn find_the_longest_substring(s: String) -> i32 {
        let mut state = 0;
        let mut max_len = 0;
        let mut index = vec![-1; 32];
        index[0] = 0;

        for (i, c) in s.chars().enumerate() {
            match c {
                'a' => state ^= 1 << 0,
                'e' => state ^= 1 << 1,
                'i' => state ^= 1 << 2,
                'o' => state ^= 1 << 3,
                'u' => state ^= 1 << 4,
                _ => {}
            }

            if index[state as usize] == -1 {
                index[state as usize] = i as i32 + 1;
            } else {
                max_len = max_len.max(i as i32 + 1 - index[state as usize]);
            }
        }

        max_len
    }
}