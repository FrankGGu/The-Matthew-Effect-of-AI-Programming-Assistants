impl Solution {
    pub fn reverse_vowels(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() - 1;

        while left < right {
            while left < right && !Self::is_vowel(chars[left]) {
                left += 1;
            }
            while left < right && !Self::is_vowel(chars[right]) {
                right -= 1;
            }

            if left < right {
                chars.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }

    fn is_vowel(c: char) -> bool {
        let lower_c = c.to_lowercase().next().unwrap();
        lower_c == 'a' || lower_c == 'e' || lower_c == 'i' || lower_c == 'o' || lower_c == 'u'
    }
}