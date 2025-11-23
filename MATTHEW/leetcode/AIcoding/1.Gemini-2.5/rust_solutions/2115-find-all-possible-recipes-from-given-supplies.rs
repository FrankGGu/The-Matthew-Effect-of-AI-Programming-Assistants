use std::collections::HashSet;

impl Solution {
    pub fn find_all_recipes(
        recipes: Vec<String>,
        ingredients: Vec<Vec<String>>,
        supplies: Vec<String>,
    ) -> Vec<String> {
        let mut available: HashSet<String> = supplies.into_iter().collect();
        let mut made_recipes: HashSet<String> = HashSet::new();
        let mut result: Vec<String> = Vec::new();

        let num_recipes = recipes.len();
        let mut changed = true;

        while changed {
            changed = false;
            for i in 0..num_recipes {
                let recipe_name = &recipes[i];

                if made_recipes.contains(recipe_name) {
                    continue;
                }

                let recipe_ingredients = &ingredients[i];
                let mut can_make = true;

                for ingredient in recipe_ingredients {
                    if !available.contains(ingredient) {
                        can_make = false;
                        break;
                    }
                }

                if can_make {
                    available.insert(recipe_name.clone());
                    made_recipes.insert(recipe_name.clone());
                    result.push(recipe_name.clone());
                    changed = true;
                }
            }
        }

        result
    }
}