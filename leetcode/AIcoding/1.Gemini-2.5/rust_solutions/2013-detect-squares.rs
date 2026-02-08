use std::collections::HashMap;

struct DetectSquares {
    points: HashMap<i32, HashMap<i32, i32>>,
}

impl DetectSquares {
    fn new() -> Self {
        DetectSquares {
            points: HashMap::new(),
        }
    }

    fn add(&mut self, point: Vec<i32>) {
        let x = point[0];
        let y = point[1];
        *self.points.entry(x).or_default().entry(y).or_insert(0) += 1;
    }

    fn count(&self, point: Vec<i32>) -> i32 {
        let x1 = point[0];
        let y1 = point[1];
        let mut total_squares = 0;

        // If there are no points with the same x-coordinate as the query point,
        // no squares can be formed with it as a corner.
        let Some(y_map_for_x1) = self.points.get(&x1) else {
            return 0;
        };

        // Iterate over all points (x1, y2) that share the same x-coordinate as the query point (x1, y1).
        // These points will serve as the second vertex (P2) of a potential square.
        for (&y2, &count_p2) in y_map_for_x1.iter() {
            // P2 must be distinct from P1 (y2 != y1) to form a non-degenerate square.
            // This also implies the side length 'd' will be non-zero.
            if y2 == y1 {
                continue;
            }

            // The side length 'd' of the square is the absolute difference in y-coordinates.
            let d = (y1 - y2).abs();

            // For an axis-aligned square with P1=(x1, y1) and P2=(x1, y2),
            // the other two vertices P3=(x2, y1) and P4=(x2, y2) must have x2 such that |x1 - x2| == d.
            // There are two possibilities for x2: x1 + d and x1 - d.

            // Case 1: x2 = x1 + d
            let x2_candidate_1 = x1 + d;
            if let Some(y_map_for_x2_1) = self.points.get(&x2_candidate_1) {
                // Check if P3 = (x2_candidate_1, y1) exists
                if let Some(&count_p3) = y_map_for_x2_1.get(&y1) {
                    // Check if P4 = (x2_candidate_1, y2) exists
                    if let Some(&count_p4) = y_map_for_x2_1.get(&y2) {
                        // If all four points exist, multiply their counts to get the number of squares.
                        total_squares += count_p2 * count_p3 * count_p4;
                    }
                }
            }

            // Case 2: x2 = x1 - d
            let x2_candidate_2 = x1 - d;
            if let Some(y_map_for_x2_2) = self.points.get(&x2_candidate_2) {
                // Check if P3 = (x2_candidate_2, y1) exists
                if let Some(&count_p3) = y_map_for_x2_2.get(&y1) {
                    // Check if P4 = (x2_candidate_2, y2) exists
                    if let Some(&count_p4) = y_map_for_x2_2.get(&y2) {
                        // If all four points exist, multiply their counts to get the number of squares.
                        total_squares += count_p2 * count_p3 * count_p4;
                    }
                }
            }
        }

        total_squares
    }
}