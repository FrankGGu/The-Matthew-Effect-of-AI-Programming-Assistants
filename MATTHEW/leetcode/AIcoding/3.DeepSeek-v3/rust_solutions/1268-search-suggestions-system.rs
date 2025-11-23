impl Solution {
    pub fn suggested_products(mut products: Vec<String>, search_word: String) -> Vec<Vec<String>> {
        products.sort_unstable();
        let mut res = Vec::new();
        let mut prefix = String::new();

        for c in search_word.chars() {
            prefix.push(c);
            let start = products.partition_point(|s| s < &prefix);
            let mut suggestions = Vec::new();
            for i in start..products.len() {
                if products[i].starts_with(&prefix) && suggestions.len() < 3 {
                    suggestions.push(products[i].clone());
                } else {
                    break;
                }
            }
            res.push(suggestions);
        }
        res
    }
}