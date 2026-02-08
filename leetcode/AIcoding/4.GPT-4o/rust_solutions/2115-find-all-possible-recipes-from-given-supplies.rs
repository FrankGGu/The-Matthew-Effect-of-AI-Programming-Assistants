use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_all_recipes(recipes: Vec<String>, ingredients: Vec<Vec<String>>, supplies: Vec<String>) -> Vec<String> {
        let mut recipe_map: HashMap<String, Vec<String>> = HashMap::new();
        let mut indegree: HashMap<String, usize> = HashMap::new();
        let mut supplies_set: HashSet<String> = supplies.into_iter().collect();

        for (i, recipe) in recipes.iter().enumerate() {
            indegree.insert(recipe.clone(), ingredients[i].len());
            for ingredient in &ingredients[i] {
                recipe_map.entry(ingredient.clone()).or_default().push(recipe.clone());
            }
        }

        let mut result = Vec::new();
        let mut queue = supplies_set.clone();

        while !queue.is_empty() {
            let current_supply = queue.iter().cloned().collect::<Vec<String>>();
            queue.clear();

            for supply in current_supply {
                if let Some(recipes) = recipe_map.get(&supply) {
                    for recipe in recipes {
                        let count = indegree.get_mut(recipe).unwrap();
                        *count -= 1;
                        if *count == 0 {
                            result.push(recipe.clone());
                            queue.insert(recipe.clone());
                        }
                    }
                }
            }
        }

        result
    }
}