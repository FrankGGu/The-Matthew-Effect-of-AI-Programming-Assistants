impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = img.len();
        let n = img[0].len();
        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut sum = 0;
                let mut count = 0;
                for di in -1..=1 {
                    for dj in -1..=1 {
                        let ni = i as i32 + di;
                        let nj = j as i32 + dj;
                        if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                            sum += img[ni as usize][nj as usize];
                            count += 1;
                        }
                    }
                }
                result[i][j] = sum / count;
            }
        }

        result
    }
}