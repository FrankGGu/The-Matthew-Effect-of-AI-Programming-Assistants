impl Solution {
    pub fn count_vowel_substrings(word: String, k: i32) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let n = word.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let sub = &word[i..=j];
                let mut vowel_count = [0; 5];
                let mut consonant_count = 0;
                let mut valid = true;

                for c in sub.chars() {
                    match c {
                        'a' => vowel_count[0] += 1,
                        'e' => vowel_count[1] += 1,
                        'i' => vowel_count[2] += 1,
                        'o' => vowel_count[3] += 1,
                        'u' => vowel_count[4] += 1,
                        _ => consonant_count += 1,
                    }
                }

                for &v in &vowel_count {
                    if v == 0 {
                        valid = false;
                        break;
                    }
                }

                if valid && consonant_count == k {
                    count += 1;
                }
            }
        }

        count
    }
}