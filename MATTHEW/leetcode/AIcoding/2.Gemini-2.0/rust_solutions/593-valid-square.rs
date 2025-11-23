impl Solution {
    pub fn valid_square(p1: Vec<i32>, p2: Vec<i32>, p3: Vec<i32>, p4: Vec<i32>) -> bool {
        let points = vec![p1, p2, p3, p4];
        let mut distances: Vec<i32> = Vec::new();

        for i in 0..4 {
            for j in i + 1..4 {
                let dist = (points[i][0] - points[j][0]).pow(2) + (points[i][1] - points[j][1]).pow(2);
                if dist == 0 {
                    return false;
                }
                distances.push(dist);
            }
        }

        distances.sort();

        distances[0] == distances[1] && distances[1] == distances[2] && distances[2] == distances[3] &&
        distances[4] == distances[5] && distances[4] == distances[0] * 2
    }
}