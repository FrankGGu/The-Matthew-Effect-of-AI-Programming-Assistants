impl Solution {
    pub fn total_characters_after_transform(s: String) -> i32 {
        let mut s = s.chars().collect::<Vec<char>>();
        let mut changed = true;
        while changed {
            changed = false;
            let mut i = 0;
            while i < s.len() {
                if i + 1 < s.len() && s[i] as u8 + 1 == s[i + 1] as u8 {
                    s[i] = (s[i] as u8 + 2) as char;
                    s.remove(i + 1);
                    changed = true;
                } else {
                    i += 1;
                }
            }
        }
        s.len() as i32
    }
}