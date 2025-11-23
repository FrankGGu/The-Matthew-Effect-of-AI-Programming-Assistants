impl Solution {
    pub fn two_edit_words(queries: Vec<String>, dictionary: Vec<String>) -> Vec<String> {
        queries.into_iter().filter(|query| {
            dictionary.iter().any(|dict_word| {
                query.chars().zip(dict_word.chars()).filter(|(a, b)| a != b).count() <= 2
            })
        }).collect()
    }
}