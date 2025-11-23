impl Solution {
    pub fn max_value(r: Vec<Vec<i32>>) -> i32 {
        let n = r.len();
        let m = r[0].len();
        let mut max_sum = 0;

        for i in 0..n {
            for j in 0..m {
                for k in 0..n {
                    for l in 0..m {
                        if i != k && j != l {
                            max_sum = max_sum.max(r[i][j] + r[k][l]);
                        }
                    }
                }
            }
        }

        max_sum
    }
}