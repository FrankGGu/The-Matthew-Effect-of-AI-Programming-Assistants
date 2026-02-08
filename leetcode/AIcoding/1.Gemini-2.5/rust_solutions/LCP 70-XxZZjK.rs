struct Solution;

impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity: i32) -> i32 {
        let n = plants.len();
        let mut steps = 0;
        let mut current_water = capacity;

        for i in 0..n {
            // Check if we have enough water for the current plant
            if current_water < plants[i] {
                // Refill needed
                // Steps to go back to -1 from the previous plant's position (i-1)
                // and then back to the previous plant's position (i-1).
                // The distance from -1 to (i-1) is i. So, 2 * i steps for the round trip.
                steps += (i * 2) as i32;
                current_water = capacity; // Refill the watering can
            }

            // Water the plant
            current_water -= plants[i];

            // Walk to the current plant from the previous position (or from -1 for the first plant)
            steps += 1;
        }

        steps
    }
}