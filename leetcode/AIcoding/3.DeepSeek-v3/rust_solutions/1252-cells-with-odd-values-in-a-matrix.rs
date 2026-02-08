impl Solution {
    pub fn odd_cells(m: i32, n: i32, indices: Vec<Vec<i32>>) -> i32 {
        let mut rows = vec![0; m as usize];
        let mut cols = vec![0; n as usize];

        for index in indices {
            let r = index[0] as usize;
            let c = index[1] as usize;
            rows[r] += 1;
            cols[c] += 1;
        }

        let mut odd = 0;
        for i in 0..m as usize {
            for j in 0..n as usize {
                if (rows[i] + cols[j]) % 2 != 0 {
                    odd += 1;
                }
            }
        }

        odd
    }
}