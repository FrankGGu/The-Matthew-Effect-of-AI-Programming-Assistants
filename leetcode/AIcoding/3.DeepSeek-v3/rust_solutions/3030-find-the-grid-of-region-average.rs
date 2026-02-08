impl Solution {
    pub fn result_grid(image: Vec<Vec<i32>>, threshold: i32) -> Vec<Vec<i32>> {
        let m = image.len();
        let n = image[0].len();
        let mut sum = vec![vec![0; n]; m];
        let mut count = vec![vec![0; n]; m];

        for i in 0..m.saturating_sub(2) {
            for j in 0..n.saturating_sub(2) {
                let mut is_region = true;
                for x in i..i+3 {
                    for y in j..j+3 {
                        if x > i && (image[x][y] - image[x-1][y]).abs() > threshold {
                            is_region = false;
                        }
                        if y > j && (image[x][y] - image[x][y-1]).abs() > threshold {
                            is_region = false;
                        }
                    }
                }
                if is_region {
                    let mut total = 0;
                    for x in i..i+3 {
                        for y in j..j+3 {
                            total += image[x][y];
                        }
                    }
                    let avg = total / 9;
                    for x in i..i+3 {
                        for y in j..j+3 {
                            sum[x][y] += avg;
                            count[x][y] += 1;
                        }
                    }
                }
            }
        }

        let mut result = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                if count[i][j] > 0 {
                    result[i][j] = sum[i][j] / count[i][j];
                } else {
                    result[i][j] = image[i][j];
                }
            }
        }
        result
    }
}