impl Solution {
    pub fn kth_smallest_path(destination: Vec<i32>, k: i32) -> String {
        let (v, h) = (destination[0], destination[1]);
        let mut k = k - 1;
        let mut res = String::new();
        let mut comb = Self::combinations((v + h) as usize, v as usize);

        for i in 0..(v + h) as usize {
            let remaining = (v + h) as usize - i - 1;
            let v_remaining = v as usize;

            if v_remaining > remaining {
                res.push('V');
                v -= 1;
                continue;
            }

            let c = comb[remaining][v_remaining];
            if k < c {
                res.push('H');
            } else {
                res.push('V');
                k -= c;
                v -= 1;
            }
        }

        res
    }

    fn combinations(total: usize, choose: usize) -> Vec<Vec<i32>> {
        let mut comb = vec![vec![0; choose + 1]; total + 1];
        comb[0][0] = 1;

        for n in 1..=total {
            comb[n][0] = 1;
            for k in 1..=choose {
                comb[n][k] = comb[n - 1][k - 1] + comb[n - 1][k];
            }
        }

        comb
    }
}