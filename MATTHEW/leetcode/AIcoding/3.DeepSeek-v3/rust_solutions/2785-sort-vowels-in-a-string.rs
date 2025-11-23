impl Solution {
    pub fn sort_vowels(s: String) -> String {
        let vowels: Vec<char> = vec!['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
        let mut vowel_indices = Vec::new();
        let mut vowel_chars = Vec::new();
        let mut s_chars: Vec<char> = s.chars().collect();

        for (i, &c) in s_chars.iter().enumerate() {
            if vowels.contains(&c) {
                vowel_indices.push(i);
                vowel_chars.push(c);
            }
        }

        vowel_chars.sort();

        for (i, &idx) in vowel_indices.iter().enumerate() {
            s_chars[idx] = vowel_chars[i];
        }

        s_chars.into_iter().collect()
    }
}