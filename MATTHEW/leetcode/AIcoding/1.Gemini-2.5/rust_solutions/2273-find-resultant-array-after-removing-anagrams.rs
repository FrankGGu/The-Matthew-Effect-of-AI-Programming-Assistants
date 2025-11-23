impl Solution {
    pub fn find_resultant_array_after_removing_anagrams(words: Vec<String>) -> Vec<String> {
        if words.is_empty() {
            return Vec::new();
        }

        let mut result = Vec::new();
        result.push(words[0].clone());

        for i in 1..words.len() {
            let last_in_result = result.last().unwrap();
            let current_word = &words[i];

            if !Self::is_anagram(last_in_result, current_word) {
                result.push(current_word.clone());
            }
        }

        result
    }

    fn is_anagram(s1: &str, s2: &str) -> bool {
        if s1.len() != s2.len() {
            return false;
        }

        let mut counts = [0; 26];
        for c in s1.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }
        for c in s2.chars() {
            counts[(c as u8 - b'a') as usize] -= 1;
        }

        for &count in counts.iter() {
            if count != 0 {
                return false;
            }
        }
        true
    }
}