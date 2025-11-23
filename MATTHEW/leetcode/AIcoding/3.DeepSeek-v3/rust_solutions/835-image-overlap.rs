impl Solution {
    pub fn largest_overlap(img1: Vec<Vec<i32>>, img2: Vec<Vec<i32>>) -> i32 {
        let n = img1.len();
        let mut max_overlap = 0;

        for di in -(n as i32) + 1..n as i32 {
            for dj in -(n as i32) + 1..n as i32 {
                let mut overlap = 0;
                for i in 0..n {
                    for j in 0..n {
                        let ni = i as i32 + di;
                        let nj = j as i32 + dj;
                        if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                            if img1[i][j] == 1 && img2[ni as usize][nj as usize] == 1 {
                                overlap += 1;
                            }
                        }
                    }
                }
                max_overlap = max_overlap.max(overlap);
            }
        }

        max_overlap
    }
}