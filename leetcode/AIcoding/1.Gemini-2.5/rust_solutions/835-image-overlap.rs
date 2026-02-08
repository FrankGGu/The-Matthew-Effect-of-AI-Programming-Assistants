impl Solution {
    pub fn largest_overlap(img1: Vec<Vec<i32>>, img2: Vec<Vec<i32>>) -> i32 {
        let n = img1.len();
        let mut max_overlap = 0;

        // Iterate through all possible vertical shifts (dr)
        // dr ranges from -(n-1) to (n-1)
        for dr in -(n as i32 - 1)..=(n as i32 - 1) {
            // Iterate through all possible horizontal shifts (dc)
            // dc ranges from -(n-1) to (n-1)
            for dc in -(n as i32 - 1)..=(n as i32 - 1) {
                let mut current_overlap = 0;

                // For each shift (dr, dc), calculate the overlap
                // Iterate through all cells (r1, c1) in img1
                for r1 in 0..n {
                    for c1 in 0..n {
                        // If img1[r1][c1] is a '1'
                        if img1[r1][c1] == 1 {
                            // Calculate the corresponding cell (r2, c2) in img2
                            // If img2 is shifted by (dr, dc), then img2[r2][c2] aligns with img1[r1][c1]
                            // such that r1 = r2 + dr and c1 = c2 + dc.
                            // Therefore, r2 = r1 - dr and c2 = c1 - dc.
                            let r2 = (r1 as i32) - dr;
                            let c2 = (c1 as i32) - dc;

                            // Check if (r2, c2) is within the bounds of img2
                            if r2 >= 0 && r2 < n as i32 && c2 >= 0 && c2 < n as i32 {
                                // If img2[r2][c2] is also a '1', then we have an overlap
                                if img2[r2 as usize][c2 as usize] == 1 {
                                    current_overlap += 1;
                                }
                            }
                        }
                    }
                }
                max_overlap = max_overlap.max(current_overlap);
            }
        }

        max_overlap
    }
}