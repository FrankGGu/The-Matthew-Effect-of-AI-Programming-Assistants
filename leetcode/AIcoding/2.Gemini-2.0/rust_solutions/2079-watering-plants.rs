impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity: i32) -> i32 {
        let mut steps = 0;
        let mut current_water = capacity;
        for i in 0..plants.len() {
            if current_water >= plants[i] {
                steps += 1;
                current_water -= plants[i];
            } else {
                steps += i as i32;
                steps += i as i32 + 1;
                current_water = capacity - plants[i];
            }
        }
        steps
    }
}