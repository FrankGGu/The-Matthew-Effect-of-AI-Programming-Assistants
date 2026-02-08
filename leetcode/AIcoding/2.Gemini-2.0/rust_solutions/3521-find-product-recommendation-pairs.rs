use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_product_pairs(products: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut product_to_users: HashMap<i32, HashSet<i32>> = HashMap::new();
        for i in 0..products.len() {
            for &product in &products[i] {
                product_to_users.entry(product).or_insert(HashSet::new()).insert(i as i32);
            }
        }

        let mut user_pairs: HashMap<(i32, i32), i32> = HashMap::new();
        for users in product_to_users.values() {
            let users_vec: Vec<i32> = users.iter().cloned().collect();
            for i in 0..users_vec.len() {
                for j in i + 1..users_vec.len() {
                    let user1 = users_vec[i].min(users_vec[j]);
                    let user2 = users_vec[i].max(users_vec[j]);
                    *user_pairs.entry((user1, user2)).or_insert(0) += 1;
                }
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        for (&(user1, user2), &count) in user_pairs.iter() {
            if count >= 2 {
                result.push(vec![user1, user2]);
            }
        }

        result.sort();
        result
    }
}