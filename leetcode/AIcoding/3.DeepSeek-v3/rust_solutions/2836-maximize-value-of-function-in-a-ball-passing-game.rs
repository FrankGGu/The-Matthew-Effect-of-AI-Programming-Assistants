impl Solution {
    pub fn get_max_function_value(receiver: Vec<i32>, k: i64) -> i64 {
        let n = receiver.len();
        let m = 64 - k.leading_zeros() as usize;
        let mut parent = vec![vec![0; n]; m];
        let mut sum = vec![vec![0; n]; m];

        for i in 0..n {
            parent[0][i] = receiver[i] as usize;
            sum[0][i] = i as i64;
        }

        for j in 1..m {
            for i in 0..n {
                parent[j][i] = parent[j-1][parent[j-1][i]];
                sum[j][i] = sum[j-1][i] + sum[j-1][parent[j-1][i]];
            }
        }

        let mut max_val = 0;
        for i in 0..n {
            let mut current = i as i64;
            let mut pos = i;
            let mut remaining = k;
            for j in 0..m {
                if (remaining & (1 << j)) != 0 {
                    current += sum[j][pos];
                    pos = parent[j][pos];
                    remaining ^= 1 << j;
                }
            }
            max_val = max_val.max(current);
        }
        max_val
    }
}