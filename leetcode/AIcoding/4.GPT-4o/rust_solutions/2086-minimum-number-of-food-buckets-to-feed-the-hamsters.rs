pub fn min_food_buckets(needed: Vec<i32>, capacity: i32) -> i32 {
    let mut total_buckets = 0;
    let mut current_supply = 0;

    for &food in needed.iter() {
        current_supply += food;
        if current_supply > capacity {
            total_buckets += (current_supply - capacity + capacity - 1) / capacity;
            current_supply = capacity;
        }
    }

    total_buckets
}