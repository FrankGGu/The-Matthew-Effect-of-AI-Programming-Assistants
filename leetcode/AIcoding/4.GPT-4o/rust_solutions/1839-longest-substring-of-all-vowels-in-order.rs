impl Solution {
    pub fn longest_vowel_substring(s: String) -> String {
        let vowels = "aeiou";
        let mut max_len = 0;
        let mut max_substr = String::new();
        let mut current_len = 0;
        let mut current_substr = String::new();

        for c in s.chars() {
            if vowels.contains(c) {
                if current_len == 0 || vowels.chars().position(|v| v == current_substr.chars().last().unwrap()) < vowels.chars().position(|v| v == c) {
                    current_len += 1;
                    current_substr.push(c);
                } else {
                    if current_len > max_len {
                        max_len = current_len;
                        max_substr = current_substr.clone();
                    }
                    current_len = 1;
                    current_substr = c.to_string();
                }
            } else {
                if current_len > max_len {
                    max_len = current_len;
                    max_substr = current_substr.clone();
                }
                current_len = 0;
                current_substr.clear();
            }
        }

        if current_len > max_len {
            max_substr = current_substr;
        }

        max_substr
    }
}