use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_recommendation_pairs(requests: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut user_to_products: HashMap<i32, HashSet<i32>> = HashMap::new();
        let mut product_to_users: HashMap<i32, HashSet<i32>> = HashMap::new();

        for req in &requests {
            let user = req[0];
            let product = req[1];
            user_to_products.entry(user).or_default().insert(product);
            product_to_users.entry(product).or_default().insert(user);
        }

        let mut result = Vec::new();
        let mut seen = HashSet::new();

        for req in &requests {
            let user = req[0];
            let product = req[1];

            if let Some(users) = product_to_users.get(&product) {
                for &other_user in users {
                    if other_user == user {
                        continue;
                    }
                    if let Some(products) = user_to_products.get(&other_user) {
                        for &other_product in products {
                            if other_product == product {
                                continue;
                            }
                            let pair = if product < other_product {
                                vec![product, other_product]
                            } else {
                                vec![other_product, product]
                            };
                            if !seen.contains(&pair) {
                                seen.insert(pair.clone());
                                result.push(pair);
                            }
                        }
                    }
                }
            }
        }

        result.sort();
        result
    }
}