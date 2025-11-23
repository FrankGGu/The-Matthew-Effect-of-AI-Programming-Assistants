impl Solution {
    pub fn sort_vowels(s: String) -> String {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut chars: Vec<char> = s.chars().collect();
        let mut vowels_in_order: Vec<char> = chars.iter()
            .filter(|&&c| vowels.contains(&c.to_ascii_lowercase()))
            .map(|&c| c.to_ascii_lowercase())
            .collect();
        vowels_in_order.sort();

        let mut vowel_index = 0;
        for c in &mut chars {
            if vowels.contains(&c.to_ascii_lowercase()) {
                *c = vowels_in_order[vowel_index];
                vowel_index += 1;
            }
        }

        chars.into_iter().collect()
    }
}