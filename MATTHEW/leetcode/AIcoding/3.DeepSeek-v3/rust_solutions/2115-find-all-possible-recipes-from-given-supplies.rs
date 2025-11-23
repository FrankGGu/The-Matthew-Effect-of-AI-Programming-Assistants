use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn find_all_recipes(recipes: Vec<String>, ingredients: Vec<Vec<String>>, supplies: Vec<String>) -> Vec<String> {
        let mut graph: HashMap<String, HashSet<String>> = HashMap::new();
        let mut in_degree: HashMap<String, i32> = HashMap::new();

        for (i, recipe) in recipes.iter().enumerate() {
            for ingredient in &ingredients[i] {
                graph.entry(ingredient.clone())
                    .or_default()
                    .insert(recipe.clone());
                *in_degree.entry(recipe.clone()).or_default() += 1;
            }
        }

        let mut queue: VecDeque<String> = supplies.into_iter().collect();
        let mut result = Vec::new();

        while let Some(curr) = queue.pop_front() {
            if let Some(neighbors) = graph.get(&curr) {
                for neighbor in neighbors {
                    if let Some(degree) = in_degree.get_mut(neighbor) {
                        *degree -= 1;
                        if *degree == 0 {
                            queue.push_back(neighbor.clone());
                            result.push(neighbor.clone());
                        }
                    }
                }
            }
        }

        result
    }
}