use std::collections::{BTreeMap, HashMap};

struct FoodRatings {
    food_to_cuisine: HashMap<String, String>,
    food_to_rating: HashMap<String, i32>,
    cuisine_to_foods: HashMap<String, BTreeMap<(i32, String), ()>>,
}

impl FoodRatings {
    fn new(foods: Vec<String>, cuisines: Vec<String>, ratings: Vec<i32>) -> Self {
        let mut food_to_cuisine = HashMap::new();
        let mut food_to_rating = HashMap::new();
        let mut cuisine_to_foods = HashMap::new();

        for i in 0..foods.len() {
            let food = foods[i].clone();
            let cuisine = cuisines[i].clone();
            let rating = ratings[i];

            food_to_cuisine.insert(food.clone(), cuisine.clone());
            food_to_rating.insert(food.clone(), rating);
            cuisine_to_foods
                .entry(cuisine)
                .or_insert_with(BTreeMap::new)
                .insert((-rating, food.clone()), ());
        }

        Self {
            food_to_cuisine,
            food_to_rating,
            cuisine_to_foods,
        }
    }

    fn change_rating(&mut self, food: String, new_rating: i32) {
        let old_rating = *self.food_to_rating.get(&food).unwrap();
        let cuisine = self.food_to_cuisine.get(&food).unwrap().clone();

        self.cuisine_to_foods
            .get_mut(&cuisine)
            .unwrap()
            .remove(&(-old_rating, food.clone()));
        self.cuisine_to_foods
            .entry(cuisine)
            .or_insert_with(BTreeMap::new)
            .insert((-new_rating, food.clone()), ());
        self.food_to_rating.insert(food, new_rating);
    }

    fn highest_rated(&self, cuisine: String) -> String {
        self.cuisine_to_foods
            .get(&cuisine)
            .unwrap()
            .iter()
            .next()
            .unwrap()
            .0
             .1
            .clone()
    }
}