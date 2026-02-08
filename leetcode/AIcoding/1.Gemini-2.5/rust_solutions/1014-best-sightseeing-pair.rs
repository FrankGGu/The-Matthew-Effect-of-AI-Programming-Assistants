impl Solution {
    pub fn max_score_sightseeing_pair(values: Vec<i32>) -> i32 {
        let n = values.len();
        let mut max_score = i32::MIN;

        let mut max_i_plus_val_so_far = values[0] + 0; 

        for j in 1..n {
            let current_score = max_i_plus_val_so_far + values[j] - (j as i32);
            max_score = max_score.max(current_score);

            max_i_plus_val_so_far = max_i_plus_val_so_far.max(values[j] + (j as i32));
        }

        max_score
    }
}