impl Solution {
    pub fn max_repeated_characters(s: String) -> i32 {
        let mut count = [0; 26];
        let mut max_count = 0;
        let mut max_char = 0;

        for c in s.chars() {
            count[c as usize - 'a' as usize] += 1;
            max_count = max_count.max(count[c as usize - 'a' as usize]);
        }

        for c in s.chars() {
            if count[c as usize - 'a' as usize] == max_count {
                max_char += 1;
            }
        }

        (max_count + max_char - 1).min(s.len() as i32)
    }
}