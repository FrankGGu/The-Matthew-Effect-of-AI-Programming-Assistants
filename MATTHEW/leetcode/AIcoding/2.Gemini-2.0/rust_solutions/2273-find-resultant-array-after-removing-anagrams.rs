impl Solution {
    pub fn remove_anagrams(words: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        let mut prev_sorted = String::new();

        for word in words {
            let mut sorted_word = word.chars().collect::<Vec<_>>();
            sorted_word.sort();
            let sorted_word_str = sorted_word.into_iter().collect::<String>();

            if sorted_word_str != prev_sorted {
                result.push(word.clone());
                prev_sorted = sorted_word_str;
            }
        }

        result
    }
}