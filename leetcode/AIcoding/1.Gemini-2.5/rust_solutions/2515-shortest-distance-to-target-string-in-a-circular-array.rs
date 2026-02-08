impl Solution {
    pub fn get_shortest_distance(words: Vec<String>, target: String, start_index: i32) -> i32 {
        let n = words.len() as i32;
        let mut min_dist = n;

        for k in 0..n {
            // Check clockwise
            let current_index_clockwise = (start_index + k) % n;
            if words[current_index_clockwise as usize] == target {
                min_dist = min_dist.min(k);
            }

            // Check counter-clockwise
            // (start_index - k) could be negative, so add n before modulo
            let current_index_counter_clockwise = (start_index - k + n) % n;
            if words[current_index_counter_clockwise as usize] == target {
                min_dist = min_dist.min(k);
            }
        }
        min_dist
    }
}