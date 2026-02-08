impl Solution {
    pub fn max_vowels(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s_bytes = s.as_bytes();

        let mut current_vowels_count = 0;
        let mut max_vowels_count = 0;

        #[inline(always)]
        fn is_vowel(c: u8) -> bool {
            matches!(c, b'a' | b'e' | b'i' | b'o' | b'u')
        }

        for i in 0..k {
            if is_vowel(s_bytes[i]) {
                current_vowels_count += 1;
            }
        }
        max_vowels_count = current_vowels_count;

        for i in k..n {
            if is_vowel(s_bytes[i - k]) {
                current_vowels_count -= 1;
            }
            if is_vowel(s_bytes[i]) {
                current_vowels_count += 1;
            }
            max_vowels_count = max_vowels_count.max(current_vowels_count);
        }

        max_vowels_count
    }
}