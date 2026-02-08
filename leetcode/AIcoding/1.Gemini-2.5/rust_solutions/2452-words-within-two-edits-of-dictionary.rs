impl Solution {
    pub fn two_edit_words(queries: Vec<String>, dictionary: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();

        for query_word in queries.iter() {
            let mut found_match = false;
            for dict_word in dictionary.iter() {
                let mut diff_count = 0;

                // All words have the same length as per problem constraints
                // We can use the length of any word, e.g., query_word.len()
                for i in 0..query_word.len() {
                    if query_word.as_bytes()[i] != dict_word.as_bytes()[i] {
                        diff_count += 1;
                    }
                    // Early exit if differences exceed 2
                    if diff_count > 2 {
                        break;
                    }
                }

                if diff_count <= 2 {
                    result.push(query_word.clone());
                    found_match = true;
                    break; // Found a matching dictionary word for this query, move to next query
                }
            }
        }

        result
    }
}