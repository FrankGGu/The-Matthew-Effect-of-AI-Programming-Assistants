use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq, Clone, Debug)]
struct FoodEntry {
    rating: i32,
    food_name: String,
}

impl Ord for FoodEntry {
    fn cmp(&self, other: &Self) -> Ordering {
        // Order by rating descending (higher rating comes first)
        // If ratings are equal, order by food_name ascending (lexicographically smallest food_name comes first)
        other.rating.cmp(&self.rating)
            .then_with(|| self.food_name.cmp(&other.food_name))
    }
}

impl PartialOrd for FoodEntry {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

struct FoodRatings {
    food_details: HashMap<String, (String, i32)>, // food_name -> (cuisine_name, current_rating)
    cuisine_ratings: HashMap<String, BinaryHeap<FoodEntry>>, // cuisine_name -> max_heap of FoodEntry
}

impl FoodRatings {
    fn new(foods: Vec<String>, cuisines: Vec<String>, ratings: Vec<i32>) -> Self {
        let mut food_details = HashMap::new();
        let mut cuisine_ratings = HashMap::new();

        for i in 0..foods.len() {
            let food = foods[i].clone();
            let cuisine = cuisines[i].clone();
            let rating = ratings[i];

            food_details.insert(food.clone(), (cuisine.clone(), rating));

            cuisine_ratings.entry(cuisine)
                .or_insert_with(BinaryHeap::new)
                .push(FoodEntry { rating, food_name: food });
        }

        FoodRatings {
            food_details,
            cuisine_ratings,
        }
    }

    fn change_rating(&mut self, food: String, new_rating: i32) {
        // Retrieve the current cuisine for the food.
        // We clone the tuple to own the cuisine string, as `food_details` will be mutated.
        let (cuisine, _) = self.food_details.get(&food).unwrap().clone(); 

        // Update the food's rating in food_details.
        // `food` is cloned for the `insert` operation and then for the `push` operation.
        self.food_details.insert(food.clone(), (cuisine.clone(), new_rating));

        // Push the new rating into the corresponding cuisine's heap.
        // The old entry for this food will remain in the heap but will be lazily removed later.
        self.cuisine_ratings.get_mut(&cuisine)
            .unwrap()
            .push(FoodEntry { rating: new_rating, food_name: food });
    }

    fn highest_rated_food(&mut self, cuisine: String) -> String {
        let heap = self.cuisine_ratings.get_mut(&cuisine).unwrap();

        loop {
            // Peek at the top element of the heap.
            let top_entry = heap.peek().unwrap(); 

            // Get the current actual rating for this food from food_details.
            let actual_food_details = self.food_details.get(&top_entry.food_name).unwrap();

            // Check if the top entry is still valid (its rating matches the current actual rating).
            if top_entry.rating == actual_food_details.1 { // actual_food_details.1 is the rating
                return top_entry.food_name.clone();
            } else {
                // The top entry is stale (its rating has changed), so pop it and continue the loop.
                heap.pop(); 
            }
        }
    }
}