struct Solution;

impl Solution {
    pub fn count_beautiful_substrings(s: String, k: i32) -> i32 {
        let k = k as usize;
        let mut count = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();

        for i in 0..n {
            let mut vowels = 0;
            for j in i..n {
                if s_chars[j] == 'a' || s_chars[j] == 'e' || s_chars[j] == 'i' || s_chars[j] == 'o' || s_chars[j] == 'u' {
                    vowels += 1;
                }
                if (j - i + 1) % k == 0 && vowels * 2 == j - i + 1 {
                    count += 1;
                }
            }
        }

        count
    }
}