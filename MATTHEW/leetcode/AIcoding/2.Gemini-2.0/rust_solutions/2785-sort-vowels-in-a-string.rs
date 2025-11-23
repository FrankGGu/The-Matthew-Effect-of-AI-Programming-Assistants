impl Solution {
    pub fn sort_vowels(s: String) -> String {
        let mut vowels: Vec<char> = s.chars().filter(|&c| "aeiouAEIOU".contains(c)).collect();
        vowels.sort();
        let mut vowel_idx = 0;
        let mut result = String::new();
        for c in s.chars() {
            if "aeiouAEIOU".contains(c) {
                result.push(vowels[vowel_idx]);
                vowel_idx += 1;
            } else {
                result.push(c);
            }
        }
        result
    }
}