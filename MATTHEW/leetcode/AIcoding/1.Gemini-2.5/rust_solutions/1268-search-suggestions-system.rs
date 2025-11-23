impl Solution {
    pub fn suggested_products(mut products: Vec<String>, search_word: String) -> Vec<Vec<String>> {
        products.sort_unstable();

        let mut result: Vec<Vec<String>> = Vec::new();
        let mut current_prefix = String::new();

        for i in 0..search_word.len() {
            current_prefix.push(search_word.chars().nth(i).unwrap());

            let mut suggestions_for_prefix: Vec<String> = Vec::new();

            // Find the index of the first product that is lexicographically greater than or equal to current_prefix.
            // All products starting with current_prefix must be at or after this index.
            let start_index = products.partition_point(|product| product < &current_prefix);

            // Iterate from the determined start_index to collect up to 3 matching products.
            for j in start_index..products.len() {
                if products[j].starts_with(&current_prefix) {
                    suggestions_for_prefix.push(products[j].clone());
                    if suggestions_for_prefix.len() == 3 {
                        break; // Found 3 suggestions, no need to look further.
                    }
                } else {
                    // Since the products are sorted, if the current product doesn't start
                    // with the prefix, no subsequent product will either.
                    break;
                }
            }
            result.push(suggestions_for_prefix);
        }

        result
    }
}