impl Solution {
    pub fn num_submatrix_sum_less_k(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let (m, n) = (matrix.len(), matrix[0].len());
        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix_sum[i][j] = matrix[i - 1][j - 1] + prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1];
            }
        }

        let mut count = 0;
        for r1 in 1..=m {
            for r2 in r1..=m {
                let mut sums = vec![0; n + 1];
                for c in 1..=n {
                    sums[c] = prefix_sum[r2][c] - prefix_sum[r1 - 1][c];
                }

                let mut sorted_sums = vec![0];
                for j in 1..=n {
                    let mut current_sum = 0;
                    for l in 0..=j {
                        current_sum += sums[l];
                        if current_sum < k {
                            count += 1;
                        }
                    }
                    sorted_sums.push(sums[j]);
                }
            }
        }
        count
    }
}