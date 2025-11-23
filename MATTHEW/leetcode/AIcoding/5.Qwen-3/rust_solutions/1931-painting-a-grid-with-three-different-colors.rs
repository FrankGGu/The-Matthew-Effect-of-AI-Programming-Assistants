struct Solution;

impl Solution {
    pub fn grid_game(n: i32) -> i64 {
        let n = n as usize;
        let mut top = vec![0; n];
        let mut bottom = vec![0; n];

        for i in 0..n {
            top[i] = (i as i64) * (i as i64 + 1) / 2;
            bottom[i] = ((n - 1) as i64 - i as i64) * ((n - 1) as i64 - i as i64 + 1) / 2;
        }

        let mut result = i64::MAX;
        for i in 0..n {
            let upper = top[n - 1] - top[i];
            let lower = bottom[0] - bottom[i];
            result = std::cmp::min(result, std::cmp::max(upper, lower));
        }

        result
    }
}