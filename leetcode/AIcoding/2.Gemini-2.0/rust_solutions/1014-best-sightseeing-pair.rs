impl Solution {
    pub fn max_score_sightseeing_pair(values: Vec<i32>) -> i32 {
        let mut max_so_far = values[0];
        let mut max_score = 0;
        for i in 1..values.len() {
            max_score = max_score.max(max_so_far + values[i] - i as i32);
            max_so_far = max_so_far.max(values[i] + i as i32);
        }
        max_score
    }
}