impl Solution {
    fn dist_sq(p1: &[i32], p2: &[i32]) -> i32 {
        let dx = p1[0] - p2[0];
        let dy = p1[1] - p2[1];
        dx * dx + dy * dy
    }

    pub fn valid_square(p1: Vec<i32>, p2: Vec<i32>, p3: Vec<i32>, p4: Vec<i32>) -> bool {
        let mut distances = Vec::new();
        distances.push(Self::dist_sq(&p1, &p2));
        distances.push(Self::dist_sq(&p1, &p3));
        distances.push(Self::dist_sq(&p1, &p4));
        distances.push(Self::dist_sq(&p2, &p3));
        distances.push(Self::dist_sq(&p2, &p4));
        distances.push(Self::dist_sq(&p3, &p4));

        distances.sort_unstable();

        if distances[0] == 0 {
            return false;
        }

        if distances[0] != distances[1] || distances[1] != distances[2] || distances[2] != distances[3] {
            return false;
        }

        if distances[4] != distances[5] {
            return false;
        }

        if distances[4] != 2 * distances[0] {
            return false;
        }

        true
    }
}