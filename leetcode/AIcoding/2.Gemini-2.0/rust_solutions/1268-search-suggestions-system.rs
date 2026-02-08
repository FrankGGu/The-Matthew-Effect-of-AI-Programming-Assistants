impl Solution {
    pub fn suggested_products(products: Vec<String>, search_word: String) -> Vec<Vec<String>> {
        let mut products = products;
        products.sort();
        let mut result: Vec<Vec<String>> = Vec::new();
        let mut prefix = String::new();
        for c in search_word.chars() {
            prefix.push(c);
            let mut suggestions: Vec<String> = Vec::new();
            for product in &products {
                if product.starts_with(&prefix) {
                    suggestions.push(product.clone());
                }
            }
            suggestions.sort();
            let mut top_3: Vec<String> = Vec::new();
            for i in 0..std::cmp::min(3, suggestions.len()) {
                top_3.push(suggestions[i].clone());
            }
            result.push(top_3);
        }
        result
    }
}