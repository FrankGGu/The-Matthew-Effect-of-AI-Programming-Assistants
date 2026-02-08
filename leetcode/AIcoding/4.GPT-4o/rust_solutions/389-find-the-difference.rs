impl Solution {
    pub fn find_the_difference(s: String, t: String) -> char {
        let mut count = [0; 26];
        for c in s.chars() {
            count[c as usize - 'a' as usize] -= 1;
        }
        for c in t.chars() {
            count[c as usize - 'a' as usize] += 1;
        }
        for (i, &c) in count.iter().enumerate() {
            if c > 0 {
                return (i as u8 + b'a') as char;
            }
        }
        ' '
    }
}