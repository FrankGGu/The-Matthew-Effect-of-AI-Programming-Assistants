impl Solution {
    pub fn kth_smallest_path(destination: Vec<i32>, k: i32) -> String {
        let (v, h) = (destination[1] as usize, destination[0] as usize);
        let mut k = k as usize;
        let mut ans = String::new();
        let mut comb = vec![vec![0; v + h + 1]; v + h + 1];
        for i in 0..=v + h {
            comb[i][0] = 1;
            comb[i][i] = 1;
            for j in 1..i {
                comb[i][j] = comb[i - 1][j - 1] + comb[i - 1][j];
            }
        }

        let mut h_left = h;
        let mut v_left = v;

        while h_left > 0 || v_left > 0 {
            if h_left > 0 {
                let ways = comb[h_left + v_left - 1][h_left - 1];
                if k <= ways {
                    ans.push('H');
                    h_left -= 1;
                } else {
                    ans.push('V');
                    k -= ways;
                    v_left -= 1;
                }
            } else {
                ans.push('V');
                v_left -= 1;
            }
        }

        ans
    }
}