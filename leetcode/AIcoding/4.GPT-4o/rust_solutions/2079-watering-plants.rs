pub fn watering_plants(plants: Vec<i32>, capacity: i32) -> i32 {
    let mut total_steps = 0;
    let mut current_capacity = capacity;

    for (i, &plant) in plants.iter().enumerate() {
        if current_capacity < plant {
            total_steps += 2 * i; // Go back to the river
            current_capacity = capacity; // Refill
        }
        current_capacity -= plant;
        total_steps += 1; // Water the plant
    }
    total_steps
}