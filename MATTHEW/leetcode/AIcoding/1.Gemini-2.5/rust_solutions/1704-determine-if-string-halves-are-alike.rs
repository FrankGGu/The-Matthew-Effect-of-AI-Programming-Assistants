impl Solution {
    pub fn halves_are_alike(s: String) -> bool {
        let n = s.len();
        let mid = n / 2;

        let mut count_a = 0;
        let mut count_b = 0;

        for (i, c) in s.chars().enumerate() {
            let is_vowel = matches!(c.to_ascii_lowercase(), 'a' | 'e' | 'i' | 'o' | 'u');
            if i < mid {
                if is_vowel {
                    count_a += 1;
                }
            } else {
                if is_vowel {
                    count_b += 1;
                }
            }
        }

        count_a == count_b
    }
}