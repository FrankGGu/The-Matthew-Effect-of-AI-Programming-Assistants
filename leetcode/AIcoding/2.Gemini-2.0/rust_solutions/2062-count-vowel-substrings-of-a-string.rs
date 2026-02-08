impl Solution {
    pub fn count_vowel_substrings(word: String) -> i32 {
        let n = word.len();
        let chars: Vec<char> = word.chars().collect();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let mut vowel_set = std::collections::HashSet::new();
                let mut is_vowel_substring = true;

                for k in i..=j {
                    if "aeiou".contains(chars[k]) {
                        vowel_set.insert(chars[k]);
                    } else {
                        is_vowel_substring = false;
                        break;
                    }
                }

                if is_vowel_substring && vowel_set.len() == 5 {
                    count += 1;
                }
            }
        }

        count
    }
}