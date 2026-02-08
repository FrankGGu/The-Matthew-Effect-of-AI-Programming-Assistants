use std::collections::HashMap;

pub fn find_product_recommendations(products: Vec<String>, product_recommendations: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut product_map: HashMap<String, Vec<String>> = HashMap::new();

    for (i, product) in products.iter().enumerate() {
        product_map.insert(product.clone(), product_recommendations[i].clone());
    }

    let mut result = vec![];

    for (product, recommendations) in product_map.iter() {
        let mut valid_recommendations = recommendations.clone();
        valid_recommendations.sort();
        valid_recommendations.dedup();
        result.push(vec![product.clone(), valid_recommendations.join(", ")]);
    }

    result
}