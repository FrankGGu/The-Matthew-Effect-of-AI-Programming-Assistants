impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_category_recommendation_pairs(categories: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut category_to_items = HashMap::new();
        let mut item_to_categories = HashMap::new();

        for (i, items) in categories.iter().enumerate() {
            for &item in items {
                category_to_items.entry(i).or_insert_with(HashSet::new).insert(item);
                item_to_categories.entry(item).or_insert_with(HashSet::new).insert(i);
            }
        }

        let mut result = Vec::new();
        let mut seen = HashSet::new();

        for (i, items) in categories.iter().enumerate() {
            for &item in items {
                if let Some(categories_with_item) = item_to_categories.get(&item) {
                    for &j in categories_with_item {
                        if i != j && !seen.contains(&(i, j)) && !seen.contains(&(j, i)) {
                            result.push(vec![i as i32, j as i32]);
                            seen.insert((i, j));
                            seen.insert((j, i));
                        }
                    }
                }
            }
        }

        result
    }
}
}