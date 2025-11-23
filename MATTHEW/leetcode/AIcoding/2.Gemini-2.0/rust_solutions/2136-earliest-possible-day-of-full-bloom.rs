impl Solution {
    pub fn earliest_possible_day(plant_time: Vec<i32>, grow_time: Vec<i32>) -> i32 {
        let n = plant_time.len();
        let mut plants: Vec<(i32, i32)> = plant_time.into_iter().zip(grow_time.into_iter()).collect();
        plants.sort_by_key(|&(p, g)| -g);

        let mut current_plant_day = 0;
        let mut max_bloom_day = 0;

        for (plant, grow) in plants {
            current_plant_day += plant;
            max_bloom_day = max_bloom_day.max(current_plant_day + grow);
        }

        max_bloom_day
    }
}