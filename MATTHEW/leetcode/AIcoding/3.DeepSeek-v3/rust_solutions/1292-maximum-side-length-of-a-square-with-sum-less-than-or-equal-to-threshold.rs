impl Solution {
    pub fn max_side_length(mat: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix[i][j] = mat[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        let mut max_side = 0;
        for i in 1..=m {
            for j in 1..=n {
                let possible_k = (i.min(j) as i32).min(max_side + 1);
                for k in (1..=possible_k).rev() {
                    let k = k as usize;
                    if i < k || j < k {
                        continue;
                    }
                    let sum = prefix[i][j] - prefix[i - k][j] - prefix[i][j - k] + prefix[i - k][j - k];
                    if sum <= threshold {
                        max_side = max_side.max(k as i32);
                        break;
                    }
                }
            }
        }

        max_side
    }
}