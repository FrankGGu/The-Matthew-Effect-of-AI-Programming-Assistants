impl Solution {
    pub fn earliest_full_bloom(plant_time: Vec<i32>, grow_time: Vec<i32>) -> i32 {
        let n = plant_time.len();
        let mut flowers: Vec<(i32, i32)> = Vec::with_capacity(n);

        for i in 0..n {
            flowers.push((plant_time[i], grow_time[i]));
        }

        flowers.sort_by(|a, b| b.1.cmp(&a.1));

        let mut current_plant_time = 0;
        let mut max_bloom_time = 0;

        for (p, g) in flowers {
            current_plant_time += p;
            max_bloom_time = max_bloom_time.max(current_plant_time + g);
        }

        max_bloom_time
    }
}