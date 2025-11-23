impl Solution {

use std::collections::{HashMap, BTreeSet};

struct FoodRatings {
    food_to_rating: HashMap<String, i32>,
    cuisine_to_foods: HashMap<String, BTreeSet<(i32, String)>>,
}

impl FoodRatings {
    fn new(mut foods: Vec<String>, mut cuisines: Vec<String>, mut ratings: Vec<i32>) -> Self {
        let mut food_to_rating = HashMap::new();
        let mut cuisine_to_foods = HashMap::new();

        for i in 0..foods.len() {
            let food = &foods[i];
            let cuisine = &cuisines[i];
            let rating = ratings[i];

            food_to_rating.insert(food.clone(), rating);
            cuisine_to_foods
                .entry(cuisine.clone())
                .or_insert_with(BTreeSet::new)
                .insert((-rating, food.clone()));
        }

        FoodRatings {
            food_to_rating,
            cuisine_to_foods,
        }
    }

    fn change_rating(&mut self, food: String, new_rating: i32) {
        if let Some(&old_rating) = self.food_to_rating.get(&food) {
            if old_rating != new_rating {
                let cuisine = self
                    .cuisine_to_foods
                    .iter()
                    .find(|(_, foods)| foods.contains(&(-old_rating, food.clone())))
                    .map(|(c, _)| c.clone())
                    .unwrap();

                self.cuisine_to_foods
                    .get_mut(&cuisine)
                    .unwrap()
                    .remove(&(-old_rating, food.clone()));
                self.cuisine_to_foods
                    .get_mut(&cuisine)
                    .unwrap()
                    .insert((-new_rating, food.clone()));
                self.food_to_rating.insert(food, new_rating);
            }
        }
    }

    fn highest_rated(&self, cuisine: String) -> String {
        self.cuisine_to_foods
            .get(&cuisine)
            .and_then(|foods| foods.iter().next())
            .map(|&(_, ref food)| food.clone())
            .unwrap()
    }
}
}