impl Solution {
    pub fn count_beautiful_substrings(s: String, k: i32) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut beautiful_count = 0;

        for i in 0..n {
            let mut vowels_count = 0;
            let mut consonants_count = 0;
            for j in i..n {
                let c = chars[j];
                if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                    vowels_count += 1;
                } else {
                    consonants_count += 1;
                }

                if vowels_count == consonants_count {
                    if (vowels_count as i32 * consonants_count as i32) % k == 0 {
                        beautiful_count += 1;
                    }
                }
            }
        }

        beautiful_count
    }
}