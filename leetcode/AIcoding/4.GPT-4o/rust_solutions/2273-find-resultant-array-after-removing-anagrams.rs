impl Solution {
    pub fn remove_anagrams(words: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        let mut last_sorted = String::new();

        for word in words {
            let mut sorted_word = word.chars().collect::<Vec<_>>();
            sorted_word.sort();
            let sorted_word = sorted_word.iter().collect::<String>();

            if sorted_word != last_sorted {
                result.push(word.clone());
                last_sorted = sorted_word;
            }
        }

        result
    }
}