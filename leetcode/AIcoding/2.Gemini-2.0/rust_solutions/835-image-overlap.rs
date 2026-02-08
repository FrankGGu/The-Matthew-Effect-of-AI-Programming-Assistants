impl Solution {
    pub fn largest_overlap(img1: Vec<Vec<i32>>, img2: Vec<Vec<i32>>) -> i32 {
        let n = img1.len();
        let mut count: std::collections::HashMap<(i32, i32), i32> = std::collections::HashMap::new();

        for i in 0..n {
            for j in 0..n {
                if img1[i][j] == 1 {
                    for x in 0..n {
                        for y in 0..n {
                            if img2[x][y] == 1 {
                                let dx = i as i32 - x as i32;
                                let dy = j as i32 - y as i32;
                                *count.entry((dx, dy)).or_insert(0) += 1;
                            }
                        }
                    }
                }
            }
        }

        let mut max_overlap = 0;
        for &val in count.values() {
            max_overlap = std::cmp::max(max_overlap, val);
        }

        max_overlap
    }
}