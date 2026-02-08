impl Solution {
    pub fn sort_vowels(s: String) -> String {
        let mut vowels: Vec<char> = s.chars().filter(|&c| "aeiouAEIOU".contains(c)).collect();
        vowels.sort_unstable();
        let mut vowel_iter = vowels.into_iter();
        s.chars()
            .map(|c| {
                if "aeiouAEIOU".contains(c) {
                    vowel_iter.next().unwrap()
                } else {
                    c
                }
            })
            .collect()
    }
}