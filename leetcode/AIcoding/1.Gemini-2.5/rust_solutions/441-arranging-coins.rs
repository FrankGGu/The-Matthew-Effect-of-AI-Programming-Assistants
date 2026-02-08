impl Solution {
    pub fn arrange_coins(n: i32) -> i32 {
        let n_long = n as i64;
        let mut low: i64 = 0;
        let mut high: i64 = n_long; 

        let mut ans: i64 = 0;

        while low <= high {
            let mid = low + (high - low) / 2;

            let coins_needed = mid * (mid + 1) / 2;

            if coins_needed <= n_long {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans as i32
    }
}