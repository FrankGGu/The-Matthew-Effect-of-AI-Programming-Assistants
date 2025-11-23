impl Solution {
    pub fn vowels_game(s: String) -> i64 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut count = 0;
        for i in 0..n {
            match s[i] {
                'a' | 'e' | 'i' | 'o' | 'u' => {
                    count += (i as i64 + 1) * (n as i64 - i as i64);
                }
                _ => {}
            }
        }
        count
    }
}