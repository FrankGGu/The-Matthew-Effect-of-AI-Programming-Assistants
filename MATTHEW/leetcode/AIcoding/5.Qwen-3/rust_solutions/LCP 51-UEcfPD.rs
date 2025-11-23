impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn cook_meals(meals: Vec<Vec<i32>>, cooking_time: i32) -> Vec<i32> {
        let mut count = HashMap::new();
        for meal in meals {
            for &ingredient in &meal {
                *count.entry(ingredient).or_insert(0) += 1;
            }
        }

        let mut result = Vec::new();
        for (ingredient, &num) in &count {
            if num >= cooking_time {
                result.push(*ingredient);
            }
        }

        result.sort();
        result
    }
}
}