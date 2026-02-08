impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity_a: i32, capacity_b: i32) -> i32 {
        let n = plants.len();
        let mut left = 0;
        let mut right = n - 1;
        let mut current_water_a = capacity_a;
        let mut current_water_b = capacity_b;
        let mut refills = 0;

        while left <= right {
            if left == right {
                // They meet at the same plant
                if current_water_a >= current_water_b {
                    if current_water_a < plants[left] {
                        refills += 1;
                    }
                } else {
                    if current_water_b < plants[right] {
                        refills += 1;
                    }
                }
                break; // All plants watered
            }

            // Alice waters from the left
            if current_water_a < plants[left] {
                refills += 1;
                current_water_a = capacity_a;
            }
            current_water_a -= plants[left];
            left += 1;

            // Bob waters from the right
            if current_water_b < plants[right] {
                refills += 1;
                current_water_b = capacity_b;
            }
            current_water_b -= plants[right];
            right -= 1;
        }

        refills
    }
}