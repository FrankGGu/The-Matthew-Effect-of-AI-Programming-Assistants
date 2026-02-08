impl Solution {
    pub fn count_vowel_strings_in_range(words: Vec<String>, left: i32, right: i32) -> i32 {
        let mut count = 0;
        let left_idx = left as usize;
        let right_idx = right as usize;

        for i in left_idx..=right_idx {
            let word = &words[i];

            let first_char = word.chars().next().unwrap();
            let last_char = word.chars().last().unwrap();

            if is_vowel(first_char) && is_vowel(last_char) {
                count += 1;
            }
        }
        count
    }
}

fn is_vowel(c: char) -> bool {
    matches!(c, 'a' | 'e' | 'i' | 'o' | 'u')
}