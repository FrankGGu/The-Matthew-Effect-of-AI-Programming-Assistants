impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity: i32) -> i32 {
        let mut steps: i64 = 0;
        let mut current_water: i32 = capacity;

        for (i, &plant_water_needed) in plants.iter().enumerate() {
            if current_water < plant_water_needed {
                // Not enough water, need to refill.
                // Go back to the river from current plant 'i' and return to plant 'i'.
                // Based on example output, this round trip costs 2 * i steps where i is the 0-indexed plant number.
                // This implies the river is at position 0 and plant 'i' is at position 'i'.
                steps += 2 * i as i64;
                current_water = capacity;
            }

            // Water the plant.
            current_water -= plant_water_needed;

            // Move to the current plant (from the previous plant or from the river for the first plant).
            steps += 1;
        }

        steps as i32
    }
}