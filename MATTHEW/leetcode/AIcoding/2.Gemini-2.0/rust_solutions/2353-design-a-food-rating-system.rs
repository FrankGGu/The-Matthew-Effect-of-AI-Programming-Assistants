use std::collections::{HashMap, BTreeSet};

struct FoodRatings {
    food_rating: HashMap<String, i32>,
    food_cuisine: HashMap<String, String>,
    cuisine_foods: HashMap<String, BTreeSet<(i32, String)>>,
}

impl FoodRatings {
    fn new(foods: Vec<String>, cuisines: Vec<String>, ratings: Vec<i32>) -> Self {
        let mut food_rating = HashMap::new();
        let mut food_cuisine = HashMap::new();
        let mut cuisine_foods = HashMap::new();

        for i in 0..foods.len() {
            food_rating.insert(foods[i].clone(), ratings[i]);
            food_cuisine.insert(foods[i].clone(), cuisines[i].clone());

            cuisine_foods.entry(cuisines[i].clone())
                .or_insert(BTreeSet::new())
                .insert((-ratings[i], foods[i].clone()));
        }

        FoodRatings {
            food_rating,
            food_cuisine,
            cuisine_foods,
        }
    }

    fn change_rating(&mut self, food: String, new_rating: i32) {
        let cuisine = self.food_cuisine.get(&food).unwrap().clone();

        let old_rating = self.food_rating.get(&food).unwrap();
        self.cuisine_foods.get_mut(&cuisine).unwrap().remove(&(*old_rating * -1, food.clone()));

        self.food_rating.insert(food.clone(), new_rating);
        self.cuisine_foods.get_mut(&cuisine).unwrap().insert((-new_rating, food.clone()));
    }

    fn highest_rated(&self, cuisine: String) -> String {
        self.cuisine_foods.get(&cuisine).unwrap().iter().next().unwrap().1.clone()
    }
}