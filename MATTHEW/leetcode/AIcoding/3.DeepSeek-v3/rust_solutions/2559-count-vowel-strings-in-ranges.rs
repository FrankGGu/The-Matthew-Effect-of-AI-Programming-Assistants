impl Solution {
    pub fn vowel_strings(words: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let vowels: std::collections::HashSet<char> = ['a', 'e', 'i', 'o', 'u'].iter().cloned().collect();
        let mut prefix = vec![0; words.len() + 1];

        for i in 0..words.len() {
            let word = &words[i];
            let first_char = word.chars().next().unwrap();
            let last_char = word.chars().last().unwrap();
            let is_vowel = vowels.contains(&first_char) && vowels.contains(&last_char);
            prefix[i + 1] = prefix[i] + if is_vowel { 1 } else { 0 };
        }

        queries.iter().map(|q| {
            let l = q[0] as usize;
            let r = q[1] as usize;
            prefix[r + 1] - prefix[l]
        }).collect()
    }
}