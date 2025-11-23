impl Solution {
    pub fn max_value_sum(chessboard: Vec<Vec<i32>>) -> i32 {
        let n = chessboard.len();
        let m = chessboard[0].len();
        let mut max_sum = i32::MIN;

        for i1 in 0..n {
            for j1 in 0..m {
                for i2 in 0..n {
                    for j2 in 0..m {
                        if i2 == i1 && j2 == j1 {
                            continue;
                        }
                        for i3 in 0..n {
                            for j3 in 0..m {
                                if (i3 == i1 && j3 == j1) || (i3 == i2 && j3 == j2) {
                                    continue;
                                }
                                let mut sum = chessboard[i1][j1] + chessboard[i2][j2] + chessboard[i3][j3];
                                if i1 == i2 && i2 == i3 {
                                    sum -= chessboard[i1][j1].min(chessboard[i2][j2]).min(chessboard[i3][j3]);
                                } else if j1 == j2 && j2 == j3 {
                                    sum -= chessboard[i1][j1].min(chessboard[i2][j2]).min(chessboard[i3][j3]);
                                }
                                max_sum = max_sum.max(sum);
                            }
                        }
                    }
                }
            }
        }

        max_sum
    }
}