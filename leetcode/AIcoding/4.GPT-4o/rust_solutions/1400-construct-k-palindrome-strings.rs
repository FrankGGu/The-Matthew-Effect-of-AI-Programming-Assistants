impl Solution {
    pub fn can_construct(k: i32, s: String) -> bool {
        let mut char_count = [0; 26];
        for ch in s.chars() {
            char_count[(ch as u8 - b'a') as usize] += 1;
        }

        let odd_count = char_count.iter().filter(|&&count| count % 2 != 0).count();
        odd_count <= k as usize
    }
}