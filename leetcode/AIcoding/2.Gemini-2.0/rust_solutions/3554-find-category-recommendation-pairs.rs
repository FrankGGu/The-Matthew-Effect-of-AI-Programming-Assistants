use std::collections::{HashMap, HashSet};

struct Solution {}

impl Solution {
    pub fn find_category_recommendation_pairs(
        category_affiliations: Vec<Vec<String>>,
    ) -> Vec<Vec<String>> {
        let mut user_categories: HashMap<String, HashSet<String>> = HashMap::new();
        for affiliation in &category_affiliations {
            let user = &affiliation[0];
            let category = &affiliation[1];
            user_categories
                .entry(user.clone())
                .or_insert(HashSet::new())
                .insert(category.clone());
        }

        let mut category_users: HashMap<String, HashSet<String>> = HashMap::new();
        for (user, categories) in &user_categories {
            for category in categories {
                category_users
                    .entry(category.clone())
                    .or_insert(HashSet::new())
                    .insert(user.clone());
            }
        }

        let mut recommendation_counts: HashMap<(String, String), i32> = HashMap::new();
        for (user, categories) in &user_categories {
            let categories_vec: Vec<String> = categories.iter().cloned().collect();
            for i in 0..categories_vec.len() {
                for j in i + 1..categories_vec.len() {
                    let cat1 = &categories_vec[i];
                    let cat2 = &categories_vec[j];
                    let key = if cat1 < cat2 {
                        (cat1.clone(), cat2.clone())
                    } else {
                        (cat2.clone(), cat1.clone())
                    };
                    *recommendation_counts.entry(key).or_insert(0) += 1;
                }
            }
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (key, count) in recommendation_counts {
            if count > 0 {
                result.push(vec![key.0, key.1, count.to_string()]);
            }
        }

        result.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        result
    }
}