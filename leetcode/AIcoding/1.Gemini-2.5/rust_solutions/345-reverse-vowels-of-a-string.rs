impl Solution {
    pub fn reverse_vowels(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() as isize - 1;

        while left < right {
            let is_vowel_left = match chars[left as usize] {
                'a' | 'e' | 'i' | 'o' | 'u' | 'A' | 'E' | 'I' | 'O' | 'U' => true,
                _ => false,
            };

            let is_vowel_right = match chars[right as usize] {
                'a' | 'e' | 'i' | 'o' | 'u' | 'A' | 'E' | 'I' | 'O' | 'U' => true,
                _ => false,
            };

            if is_vowel_left && is_vowel_right {
                chars.swap(left as usize, right as usize);
                left += 1;
                right -= 1;
            } else if is_vowel_left {
                right -= 1;
            } else if is_vowel_right {
                left += 1;
            } else {
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }
}