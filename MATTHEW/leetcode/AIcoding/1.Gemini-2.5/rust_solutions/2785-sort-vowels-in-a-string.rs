impl Solution {
    pub fn sort_vowels(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut vowels: Vec<char> = Vec::new();

        let is_vowel = |c: char| -> bool {
            match c {
                'a' | 'e' | 'i' | 'o' | 'u' |
                'A' | 'E' | 'I' | 'O' | 'U' => true,
                _ => false,
            }
        };

        for &c in chars.iter() {
            if is_vowel(c) {
                vowels.push(c);
            }
        }

        vowels.sort_unstable();

        let mut vowel_idx = 0;
        for i in 0..chars.len() {
            if is_vowel(chars[i]) {
                chars[i] = vowels[vowel_idx];
                vowel_idx += 1;
            }
        }

        chars.into_iter().collect()
    }
}