impl Solution {
    pub fn min_score(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let mut min_dist = i32::MAX;

        for road in roads {
            let dist = road[2];
            if dist < min_dist {
                min_dist = dist;
            }
        }

        min_dist
    }
}