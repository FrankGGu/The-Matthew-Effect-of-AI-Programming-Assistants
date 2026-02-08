impl Solution {
    pub fn earliest_full_bloom(plant_time: Vec<i32>, grow_time: Vec<i32>) -> i32 {
        let mut indices: Vec<usize> = (0..grow_time.len()).collect();
        indices.sort_by(|&a, &b| grow_time[b].cmp(&grow_time[a]));

        let mut current_plant_time = 0;
        let mut result = 0;

        for &i in &indices {
            current_plant_time += plant_time[i];
            result = result.max(current_plant_time + grow_time[i]);
        }

        result
    }
}