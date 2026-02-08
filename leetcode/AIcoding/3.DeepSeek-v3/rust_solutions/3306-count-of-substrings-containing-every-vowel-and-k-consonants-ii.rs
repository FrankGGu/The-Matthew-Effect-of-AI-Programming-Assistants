use std::collections::HashMap;

impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let vowels: [u8; 5] = [b'a', b'e', b'i', b'o', b'u'];
        let mut res = 0;

        for i in 0..n {
            let mut vowel_count = 0;
            let mut consonant_count = 0;
            let mut vowel_present = [false; 5];

            for j in i..n {
                let c = s[j];
                let mut is_vowel = false;
                for (idx, &v) in vowels.iter().enumerate() {
                    if c == v {
                        is_vowel = true;
                        if !vowel_present[idx] {
                            vowel_present[idx] = true;
                            vowel_count += 1;
                        }
                        break;
                    }
                }
                if !is_vowel {
                    consonant_count += 1;
                }

                if vowel_count == 5 && consonant_count == k {
                    res += 1;
                }
            }
        }

        res
    }
}