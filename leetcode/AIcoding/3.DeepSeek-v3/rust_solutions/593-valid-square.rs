use std::collections::HashSet;

impl Solution {
    pub fn valid_square(p1: Vec<i32>, p2: Vec<i32>, p3: Vec<i32>, p4: Vec<i32>) -> bool {
        let points = vec![p1, p2, p3, p4];
        let mut distances = HashSet::new();

        for i in 0..4 {
            for j in i+1..4 {
                let dx = points[i][0] - points[j][0];
                let dy = points[i][1] - points[j][1];
                let distance = dx * dx + dy * dy;
                if distance == 0 {
                    return false;
                }
                distances.insert(distance);
            }
        }

        distances.len() == 2
    }
}