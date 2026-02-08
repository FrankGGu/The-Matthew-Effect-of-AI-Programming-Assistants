use std::collections::HashMap;

pub fn suggested_products(products: Vec<String>, search_word: String) -> Vec<Vec<String>> {
    let mut products = products;
    products.sort();
    let mut result = Vec::new();
    let mut prefix = String::new();

    for ch in search_word.chars() {
        prefix.push(ch);
        let mut suggestions = Vec::new();
        for product in &products {
            if product.starts_with(&prefix) {
                suggestions.push(product.clone());
            }
            if suggestions.len() == 3 {
                break;
            }
        }
        result.push(suggestions);
    }

    result
}