use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn find_all_recipes(recipes: Vec<String>, ingredients: Vec<Vec<String>>, supplies: Vec<String>) -> Vec<String> {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut in_degree: HashMap<String, i32> = HashMap::new();

        let supply_set: HashSet<String> = supplies.into_iter().collect();
        let recipe_set: HashSet<String> = recipes.iter().cloned().collect();

        for recipe in &recipes {
            in_degree.insert(recipe.clone(), 0);
        }

        for (i, recipe) in recipes.iter().enumerate() {
            for ingredient in &ingredients[i] {
                if !supply_set.contains(ingredient) {
                    if !recipe_set.contains(ingredient) {
                        in_degree.insert(ingredient.clone(), 1);
                    }

                    if recipe_set.contains(ingredient) {
                        graph.entry(ingredient.clone()).or_insert(Vec::new()).push(recipe.clone());
                        *in_degree.entry(recipe.clone()).or_insert(0) += 1;
                    } else {
                        *in_degree.entry(recipe.clone()).or_insert(0) += 1;
                    }
                }
            }
        }

        let mut queue: VecDeque<String> = VecDeque::new();
        for (recipe, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(recipe.clone());
            }
        }

        let mut result: Vec<String> = Vec::new();
        while let Some(node) = queue.pop_front() {
            if recipe_set.contains(&node) {
                result.push(node.clone());
            }

            if let Some(neighbors) = graph.get(&node) {
                for neighbor in neighbors {
                    *in_degree.get_mut(neighbor).unwrap() -= 1;
                    if *in_degree.get(neighbor).unwrap() == 0 {
                        queue.push_back(neighbor.clone());
                    }
                }
            }
        }

        result
    }
}