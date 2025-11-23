struct Solution;

impl Solution {
    pub fn watering_plants(a: Vec<i32>, w: i32) -> i32 {
        let mut steps = 0;
        let mut current_water = 0;
        for (i, &need) in a.iter().enumerate() {
            if current_water < need {
                steps += (i as i32) * 2;
                current_water = w;
            }
            steps += 1;
            current_water -= need;
        }
        steps
    }
}