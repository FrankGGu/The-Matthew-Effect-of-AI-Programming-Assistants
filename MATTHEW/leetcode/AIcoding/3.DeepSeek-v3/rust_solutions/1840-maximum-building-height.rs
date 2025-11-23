use std::cmp;

impl Solution {
    pub fn max_building(n: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        let mut res = Vec::with_capacity(restrictions.len() + 2);
        res.push(vec![1, 0]);
        res.extend(restrictions.into_iter());
        res.sort_by_key(|v| v[0]);
        if res.last().unwrap()[0] != n {
            res.push(vec![n, n - 1]);
        }

        let m = res.len();
        for i in 1..m {
            res[i][1] = cmp::min(res[i][1], res[i - 1][1] + (res[i][0] - res[i - 1][0]));
        }
        for i in (0..m - 1).rev() {
            res[i][1] = cmp::min(res[i][1], res[i + 1][1] + (res[i + 1][0] - res[i][0]));
        }

        let mut max = 0;
        for i in 0..m - 1 {
            let (id1, h1) = (res[i][0], res[i][1]);
            let (id2, h2) = (res[i + 1][0], res[i + 1][1]);
            let diff = (id2 - id1).abs();
            let h = cmp::max(h1, h2) + (diff - (h1 - h2).abs()) / 2;
            max = cmp::max(max, h);
        }
        max
    }
}