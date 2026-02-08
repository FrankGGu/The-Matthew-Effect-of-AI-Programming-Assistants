use std::collections::HashMap;

impl Solution {
    pub fn min_area_rect_ii(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        if n < 4 {
            return 0.0;
        }

        // Map from (squared_diagonal_length, doubled_mid_x, doubled_mid_y) to a list of (index1, index2) pairs
        // Using doubled coordinates for midpoints to avoid floating-point arithmetic.
        let mut diagonals_map: HashMap<(i64, i64, i64), Vec<(usize, usize)>> = HashMap::new();

        for i in 0..n {
            for j in (i + 1)..n {
                let p1 = &points[i];
                let p2 = &points[j];

                let dx = (p1[0] - p2[0]) as i64;
                let dy = (p1[1] - p2[1]) as i64;

                let dist_sq = dx * dx + dy * dy;
                let mid_x = (p1[0] + p2[0]) as i64;
                let mid_y = (p1[1] + p2[1]) as i64;

                diagonals_map.entry((dist_sq, mid_x, mid_y))
                    .or_insert_with(Vec::new)
                    .push((i, j));
            }
        }

        let mut min_area = f64::MAX;

        for (_, diagonal_pairs) in diagonals_map.iter() {
            if diagonal_pairs.len() < 2 {
                continue;
            }

            // Iterate through all pairs of diagonals that share the same midpoint and length
            for k in 0..diagonal_pairs.len() {
                for l in (k + 1)..diagonal_pairs.len() {
                    let (idx1, idx2) = diagonal_pairs[k];
                    let (idx3, idx4) = diagonal_pairs[l];

                    // The four points points[idx1], points[idx2], points[idx3], points[idx4] form a parallelogram.
                    // Let the vertices of the parallelogram be P_idx1, P_idx3, P_idx2, P_idx4.
                    // To form a rectangle, two adjacent sides must be perpendicular.
                    // Check if vector P_idx1 P_idx3 is perpendicular to P_idx3 P_idx2.
                    // This is done by checking if their dot product is zero.

                    let p_idx1 = &points[idx1];
                    let p_idx2 = &points[idx2];
                    let p_idx3 = &points[idx3];

                    // Vector P_idx1 P_idx3
                    let v1_x = (p_idx3[0] - p_idx1[0]) as i64;
                    let v1_y = (p_idx3[1] - p_idx1[1]) as i64;

                    // Vector P_idx3 P_idx2
                    let v2_x = (p_idx2[0] - p_idx3[0]) as i64;
                    let v2_y = (p_idx2[1] - p_idx3[1]) as i64;

                    // Dot product check for perpendicularity
                    if v1_x * v2_x + v1_y * v2_y == 0 {
                        // If dot product is zero, the sides are perpendicular, forming a rectangle.
                        let side1_sq = v1_x * v1_x + v1_y * v1_y;
                        let side2_sq = v2_x * v2_x + v2_y * v2_y;

                        // Since points are unique and we've established distinct indices,
                        // side1_sq and side2_sq will be greater than 0.

                        let current_area = (side1_sq as f64 * side2_sq as f64).sqrt();
                        min_area = min_area.min(current_area);
                    }
                }
            }
        }

        if min_area == f64::MAX {
            0.0
        } else {
            min_area
        }
    }
}