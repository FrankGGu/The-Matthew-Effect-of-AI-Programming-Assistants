impl Solution {
    pub fn max_score_sightseeing_pair(values: Vec<i32>) -> i32 {
        let n = values.len();
        let mut max_score = 0;
        let mut max_a_i_plus_i = values[0] + 0; // Represents max(values[k] + k) for k < j

        for j in 1..n {
            // Calculate score for current j using the best i found so far (max_a_i_plus_i)
            max_score = max_score.max(max_a_i_plus_i + values[j] - j as i32);

            // Update max_a_i_plus_i to include the current j for future iterations
            max_a_i_plus_i = max_a_i_plus_i.max(values[j] + j as i32);
        }

        max_score
    }
}