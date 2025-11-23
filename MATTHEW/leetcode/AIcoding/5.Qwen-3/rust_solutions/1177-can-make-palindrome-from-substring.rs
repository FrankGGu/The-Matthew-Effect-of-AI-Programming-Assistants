struct Solution;

impl Solution {
    pub fn can_make_palindrome_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let s = s.as_bytes();
        let n = s.len();
        let mut prefix = vec![vec![0; 26]; n + 1];

        for i in 0..n {
            for j in 0..26 {
                prefix[i + 1][j] = prefix[i][j];
            }
            let c = (s[i] - b'a') as usize;
            prefix[i + 1][c] += 1;
        }

        let mut res = vec![];

        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let k = q[2] as usize;

            let mut cnt = [0; 26];
            for i in 0..26 {
                cnt[i] = prefix[r + 1][i] - prefix[l][i];
            }

            let mut odd = 0;
            for i in 0..26 {
                if cnt[i] % 2 != 0 {
                    odd += 1;
                }
            }

            if odd <= 2 * k {
                res.push(true);
            } else {
                res.push(false);
            }
        }

        res
    }
}