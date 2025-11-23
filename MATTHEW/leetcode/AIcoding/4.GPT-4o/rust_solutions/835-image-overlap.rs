impl Solution {
    pub fn largest_overlap(img1: Vec<Vec<i32>>, img2: Vec<Vec<i32>>) -> i32 {
        let n = img1.len();
        let mut max_overlap = 0;

        let mut count: Vec<i32> = vec![0; 2 * n + 1];

        for i in 0..n {
            for j in 0..n {
                if img1[i][j] == 1 {
                    for x in 0..n {
                        for y in 0..n {
                            if img2[x][y] == 1 {
                                let dx = x as i32 - i as i32;
                                let dy = y as i32 - j as i32;
                                if dx >= -n as i32 && dx < n as i32 && dy >= -n as i32 && dy < n as i32 {
                                    count[(dx + n as i32) as usize + (dy + n as i32) as usize] += 1;
                                    max_overlap = max_overlap.max(count[(dx + n as i32) as usize + (dy + n as i32) as usize]);
                                }
                            }
                        }
                    }
                }
            }
        }
        max_overlap
    }
}