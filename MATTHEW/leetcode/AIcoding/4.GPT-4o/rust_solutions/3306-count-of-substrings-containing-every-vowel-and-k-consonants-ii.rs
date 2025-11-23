impl Solution {
    pub fn count_vowel_substrings(s: String, k: usize) -> i32 {
        let vowels = "aeiou".chars().collect::<std::collections::HashSet<_>>();
        let mut count = 0;
        let n = s.len();
        let s = s.chars().collect::<Vec<_>>();

        for i in 0..n {
            let mut vowel_count = 0;
            let mut consonant_count = 0;
            let mut char_count = std::collections::HashMap::new();

            for j in i..n {
                if vowels.contains(&s[j]) {
                    vowel_count += 1;
                } else {
                    consonant_count += 1;
                }
                *char_count.entry(s[j]).or_insert(0) += 1;

                if vowel_count == 5 && consonant_count >= k {
                    count += 1;
                    while char_count.len() >= 5 && consonant_count >= k {
                        if vowels.contains(&s[i]) {
                            vowel_count -= 1;
                        } else {
                            consonant_count -= 1;
                        }
                        let c = s[i];
                        if let Some(v) = char_count.get_mut(&c) {
                            *v -= 1;
                            if *v == 0 {
                                char_count.remove(&c);
                            }
                        }
                        i += 1;
                    }
                }
            }
        }
        count
    }
}