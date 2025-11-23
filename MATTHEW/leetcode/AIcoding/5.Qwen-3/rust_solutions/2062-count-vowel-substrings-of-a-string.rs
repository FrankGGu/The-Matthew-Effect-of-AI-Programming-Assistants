struct Solution;

impl Solution {
    pub fn count_vowel_substrings(s: String) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut count = 0;
        let s: Vec<char> = s.chars().collect();

        for i in 0..s.len() {
            if !vowels.contains(&s[i]) {
                continue;
            }
            let mut unique_vowels = std::collections::HashSet::new();
            unique_vowels.insert(s[i]);
            for j in i+1..s.len() {
                if !vowels.contains(&s[j]) {
                    break;
                }
                unique_vowels.insert(s[j]);
                if unique_vowels.len() == 5 {
                    count += 1;
                }
            }
        }

        count
    }
}