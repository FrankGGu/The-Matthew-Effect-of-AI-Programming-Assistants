impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity: i32) -> i32 {
        let mut steps = 0;
        let mut current_capacity = capacity;

        for (i, &water_needed) in plants.iter().enumerate() {
            if current_capacity < water_needed {
                steps += 2 * i as i32;
                current_capacity = capacity;
            }
            steps += 1;
            current_capacity -= water_needed;
        }

        steps
    }
}