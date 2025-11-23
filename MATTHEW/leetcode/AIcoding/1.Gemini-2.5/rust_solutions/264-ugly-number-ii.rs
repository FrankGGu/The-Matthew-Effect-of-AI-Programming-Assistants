impl Solution {
    pub fn nth_ugly_number(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![0; n];
        dp[0] = 1;

        let mut p2 = 0;
        let mut p3 = 0;
        let mut p5 = 0;

        for i in 1..n {
            let next_ugly_by2 = dp[p2] * 2;
            let next_ugly_by3 = dp[p3] * 3;
            let next_ugly_by5 = dp[p5] * 5;

            let next_ugly = next_ugly_by2.min(next_ugly_by3).min(next_ugly_by5);
            dp[i] = next_ugly;

            if next_ugly == next_ugly_by2 {
                p2 += 1;
            }
            if next_ugly == next_ugly_by3 {
                p3 += 1;
            }
            if next_ugly == next_ugly_by5 {
                p5 += 1;
            }
        }

        dp[n - 1]
    }
}