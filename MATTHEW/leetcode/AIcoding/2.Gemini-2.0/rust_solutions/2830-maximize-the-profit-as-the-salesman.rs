impl Solution {
    pub fn max_profit(n: i32, offers: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut offers = offers;
        offers.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut dp = vec![0; offers.len()];
        dp[0] = offers[0][2];

        for i in 1..offers.len() {
            let mut l = 0;
            let mut r = i - 1;
            let mut idx = -1;
            while l <= r {
                let mid = l + (r - l) / 2;
                if offers[mid][1] < offers[i][0] {
                    idx = mid as i32;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }

            let prev_profit = if idx == -1 {
                0
            } else {
                dp[idx as usize]
            };

            dp[i] = std::cmp::max(dp[i - 1], prev_profit + offers[i][2]);
        }

        dp[offers.len() - 1]
    }
}