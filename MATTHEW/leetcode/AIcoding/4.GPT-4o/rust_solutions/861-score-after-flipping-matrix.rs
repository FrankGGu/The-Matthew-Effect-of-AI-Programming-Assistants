impl Solution {
    pub fn matrix_score(a: Vec<Vec<i32>>) -> i32 {
        let m = a.len();
        let n = a[0].len();
        let mut score = 0;

        for j in 0..n {
            let mut count_ones = 0;
            for i in 0..m {
                if a[i][0] == 1 {
                    count_ones += a[i][j];
                } else {
                    count_ones += 1 - a[i][j];
                }
            }
            let max_count = count_ones.max(m - count_ones);
            score = (score << 1) + max_count;
        }
        score
    }
}