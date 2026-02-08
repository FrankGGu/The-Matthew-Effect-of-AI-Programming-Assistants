impl Solution {
    pub fn count_vowels(word: String) -> i64 {
        let n = word.len() as i64;
        let mut total_vowels: i64 = 0;

        for (i, c) in word.chars().enumerate() {
            if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                let i_i64 = i as i64;
                total_vowels += (i_i64 + 1) * (n - i_i64);
            }
        }

        total_vowels
    }
}