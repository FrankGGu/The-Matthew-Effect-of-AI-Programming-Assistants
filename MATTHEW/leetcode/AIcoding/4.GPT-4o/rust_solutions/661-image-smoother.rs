impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let directions = vec![
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),          (0, 0),  (0, 1),
            (1, -1), (1, 0), (1, 1),
        ];

        let (m, n) = (img.len(), img[0].len());
        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut total = 0;
                let mut count = 0;

                for (dx, dy) in &directions {
                    let x = i as isize + dx;
                    let y = j as isize + dy;
                    if x >= 0 && x < m as isize && y >= 0 && y < n as isize {
                        total += img[x as usize][y as usize];
                        count += 1;
                    }
                }

                result[i][j] = total / count;
            }
        }

        result
    }
}