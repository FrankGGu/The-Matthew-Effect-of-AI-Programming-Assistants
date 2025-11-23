impl Solution {
    pub fn reconstruct_matrix(upper: i32, lower: i32, colsum: Vec<i32>) -> Vec<Vec<i32>> {
        let n = colsum.len();
        let mut upper_count = 0;
        let mut lower_count = 0;
        let mut res = vec![vec![0; n]; 2];

        for i in 0..n {
            if colsum[i] == 2 {
                res[0][i] = 1;
                res[1][i] = 1;
                upper_count += 1;
                lower_count += 1;
            } else if colsum[i] == 1 {
                if upper_count < upper {
                    res[0][i] = 1;
                    upper_count += 1;
                } else {
                    res[1][i] = 1;
                    lower_count += 1;
                }
            }
        }

        if upper_count != upper || lower_count != lower {
            return vec![];
        }

        for i in 0..n {
            if res[0][i] + res[1][i] != colsum[i] {
                return vec![];
            }
        }

        res
    }
}