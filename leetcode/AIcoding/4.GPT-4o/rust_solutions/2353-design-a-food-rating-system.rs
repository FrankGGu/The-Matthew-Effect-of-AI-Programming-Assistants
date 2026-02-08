use std::collections::{HashMap, BinaryHeap};

struct FoodRating {
    food_map: HashMap<String, (i32, i32)>,
    heap: BinaryHeap<(i32, i32, String)>,
}

impl FoodRating {
    fn new(foods: Vec<String>, ratings: Vec<i32>) -> Self {
        let mut food_map = HashMap::new();
        let mut heap = BinaryHeap::new();

        for (i, food) in foods.iter().enumerate() {
            food_map.insert(food.clone(), (ratings[i], i as i32));
            heap.push((ratings[i], i as i32, food.clone()));
        }

        FoodRating { food_map, heap }
    }

    fn change_rating(&mut self, food: String, new_rating: i32) {
        if let Some((_, index)) = self.food_map.get_mut(&food) {
            self.heap.retain(|&(rating, idx, ref f)| f != &food);
            self.food_map.insert(food.clone(), (new_rating, *index));
            self.heap.push((new_rating, *index, food));
        }
    }

    fn highest_rated(&self) -> String {
        self.heap.peek().unwrap().2.clone()
    }
}