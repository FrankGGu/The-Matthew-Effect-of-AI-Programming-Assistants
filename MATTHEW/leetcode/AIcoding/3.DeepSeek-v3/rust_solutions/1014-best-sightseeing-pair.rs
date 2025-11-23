impl Solution {
    pub fn max_score_sightseeing_pair(values: Vec<i32>) -> i32 {
        let mut max_score = 0;
        let mut max_i = values[0];

        for j in 1..values.len() {
            max_score = max_score.max(max_i + values[j] - j as i32);
            max_i = max_i.max(values[j] + j as i32);
        }

        max_score
    }
}