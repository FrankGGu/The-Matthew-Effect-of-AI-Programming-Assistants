impl Solution {
    pub fn plates_between_candles(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let s = s.as_bytes();
        let n = s.len();
        let mut prefix = vec![0; n + 1];
        let mut left = vec![-1; n];
        let mut right = vec![-1; n];

        let mut last = -1;
        for i in 0..n {
            if s[i] == b'|' {
                last = i as i32;
            }
            left[i] = last;
        }

        last = -1;
        for i in (0..n).rev() {
            if s[i] == b'|' {
                last = i as i32;
            }
            right[i] = last;
        }

        for i in 0..n {
            prefix[i + 1] = prefix[i] + if s[i] == b'*' { 1 } else { 0 };
        }

        let mut res = Vec::with_capacity(queries.len());
        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let x = right[l] as usize;
            let y = left[r] as usize;
            if x == n || y == n || x >= y {
                res.push(0);
            } else {
                res.push((prefix[y + 1] - prefix[x]) as i32);
            }
        }
        res
    }
}