impl Solution {
    pub fn min_number_of_semesters(n: i32, relations: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut pre = vec![0; n];
        for rel in relations {
            let u = rel[0] as usize - 1;
            let v = rel[1] as usize - 1;
            pre[v] |= 1 << u;
        }

        let mut dp = vec![n as i32; 1 << n];
        dp[0] = 0;

        for mask in 0..1 << n {
            let mut available = 0;
            for i in 0..n {
                if (mask & pre[i]) == pre[i] && (mask & (1 << i)) == 0 {
                    available |= 1 << i;
                }
            }

            let mut subset = available;
            while subset > 0 {
                if subset.count_ones() as usize <= k {
                    let new_mask = mask | subset;
                    if dp[new_mask] > dp[mask] + 1 {
                        dp[new_mask] = dp[mask] + 1;
                    }
                }
                subset = (subset - 1) & available;
            }
        }

        dp[(1 << n) - 1]
    }
}