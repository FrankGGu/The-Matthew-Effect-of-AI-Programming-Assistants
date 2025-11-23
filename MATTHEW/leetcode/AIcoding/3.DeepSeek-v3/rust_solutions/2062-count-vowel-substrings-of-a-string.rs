impl Solution {
    pub fn count_vowel_substrings(word: String) -> i32 {
        let vowels: Vec<char> = vec!['a', 'e', 'i', 'o', 'u'];
        let word_chars: Vec<char> = word.chars().collect();
        let n = word_chars.len();
        let mut count = 0;

        for i in 0..n {
            let mut seen = std::collections::HashSet::new();
            for j in i..n {
                let c = word_chars[j];
                if vowels.contains(&c) {
                    seen.insert(c);
                    if seen.len() == 5 {
                        count += 1;
                    }
                } else {
                    break;
                }
            }
        }

        count
    }
}