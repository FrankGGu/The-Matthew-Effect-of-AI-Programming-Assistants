impl Solution {
    pub fn minimum_total(mut triangle: Vec<Vec<i32>>) -> i32 {
        let n = triangle.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return triangle[0][0];
        }

        for i in 1..n {
            for j in 0..=i {
                if j == 0 {
                    triangle[i][j] += triangle[i - 1][0];
                } else if j == i {
                    triangle[i][j] += triangle[i - 1][i - 1];
                } else {
                    triangle[i][j] += triangle[i - 1][j - 1].min(triangle[i - 1][j]);
                }
            }
        }

        *triangle[n - 1].iter().min().unwrap()
    }
}