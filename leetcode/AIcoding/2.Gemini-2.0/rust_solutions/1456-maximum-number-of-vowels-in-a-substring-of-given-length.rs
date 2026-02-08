impl Solution {
    pub fn max_vowels(s: String, k: i32) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let k = k as usize;
        let mut count = 0;
        for i in 0..k {
            if s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' {
                count += 1;
            }
        }
        let mut max_count = count;
        for i in k..s.len() {
            if s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' {
                count += 1;
            }
            if s[i - k] == 'a' || s[i - k] == 'e' || s[i - k] == 'i' || s[i - k] == 'o' || s[i - k] == 'u' {
                count -= 1;
            }
            max_count = max_count.max(count);
        }
        max_count
    }
}