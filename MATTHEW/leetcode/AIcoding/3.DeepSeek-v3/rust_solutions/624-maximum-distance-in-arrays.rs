impl Solution {
    pub fn max_distance(arrays: Vec<Vec<i32>>) -> i32 {
        let mut min_val = arrays[0][0];
        let mut max_val = arrays[0][arrays[0].len() - 1];
        let mut res = 0;

        for arr in arrays.iter().skip(1) {
            let current_min = arr[0];
            let current_max = arr[arr.len() - 1];
            res = res.max((current_max - min_val).abs()).max((max_val - current_min).abs());
            min_val = min_val.min(current_min);
            max_val = max_val.max(current_max);
        }

        res
    }
}