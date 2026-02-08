impl Solution {
    pub fn max_vowels(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let k = k as usize;
        let is_vowel = |c: u8| -> bool {
            match c {
                b'a' | b'e' | b'i' | b'o' | b'u' => true,
                _ => false,
            }
        };

        let mut max_vowels = 0;
        let mut current_vowels = 0;

        for i in 0..k {
            if is_vowel(s[i]) {
                current_vowels += 1;
            }
        }
        max_vowels = current_vowels;

        for i in k..s.len() {
            if is_vowel(s[i - k]) {
                current_vowels -= 1;
            }
            if is_vowel(s[i]) {
                current_vowels += 1;
            }
            if current_vowels > max_vowels {
                max_vowels = current_vowels;
            }
        }

        max_vowels
    }
}