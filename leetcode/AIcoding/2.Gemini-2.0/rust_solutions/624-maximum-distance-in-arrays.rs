impl Solution {
    pub fn max_distance(arrays: Vec<Vec<i32>>) -> i32 {
        let mut min_val = arrays[0][0];
        let mut max_val = arrays[0][arrays[0].len() - 1];
        let mut max_dist = 0;

        for i in 1..arrays.len() {
            let current_min = arrays[i][0];
            let current_max = arrays[i][arrays[i].len() - 1];

            max_dist = max_dist.max((current_max - min_val).abs());
            max_dist = max_dist.max((max_val - current_min).abs());

            min_val = min_val.min(current_min);
            max_val = max_val.max(current_max);
        }

        max_dist
    }
}