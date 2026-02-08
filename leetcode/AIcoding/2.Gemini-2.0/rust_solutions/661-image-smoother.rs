impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = img.len();
        let n = img[0].len();
        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut sum = 0;
                let mut count = 0;
                for x in i.max(0)..(i + 2).min(m) {
                    for y in j.max(0)..(j + 2).min(n) {
                        sum += img[x][y];
                        count += 1;
                    }
                }
                result[i][j] = sum / count;
            }
        }

        result
    }
}