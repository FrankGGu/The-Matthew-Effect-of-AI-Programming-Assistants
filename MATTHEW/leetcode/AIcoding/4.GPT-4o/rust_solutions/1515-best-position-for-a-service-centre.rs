impl Solution {
    pub fn best_location(locations: Vec<Vec<i32>>, radius: i32) -> Vec<i32> {
        let mut best_location = vec![-1, -1];
        let mut best_score = i32::MAX;

        for i in 0..locations.len() {
            let mut score = 0;

            for j in 0..locations.len() {
                if i != j {
                    let dist = (locations[i][0] - locations[j][0]).abs() + (locations[i][1] - locations[j][1]).abs();
                    if dist > radius {
                        score += dist - radius;
                    }
                }
            }

            if score < best_score {
                best_score = score;
                best_location = vec![locations[i][0], locations[i][1]];
            }
        }

        best_location
    }
}