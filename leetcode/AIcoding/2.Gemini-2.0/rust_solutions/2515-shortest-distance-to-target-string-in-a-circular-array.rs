impl Solution {
    pub fn shortest_distance(words: Vec<String>, target: String, start: i32) -> i32 {
        let n = words.len();
        let mut min_dist = std::i32::MAX;

        for i in 0..n {
            if words[i] == target {
                let dist1 = (i as i32 - start).abs().min((i as i32 + n as i32 - start) % n as i32).min((start + n as i32 - i as i32) % n as i32);
                min_dist = min_dist.min(dist1);
            }
        }

        min_dist
    }
}