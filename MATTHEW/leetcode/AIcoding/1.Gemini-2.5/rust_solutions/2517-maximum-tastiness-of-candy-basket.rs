impl Solution {
    pub fn maximum_tastiness(mut price: Vec<i32>, k: i32) -> i32 {
        price.sort_unstable();
        let n = price.len();

        let mut low = 0;
        let mut high = price[n - 1] - price[0];
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, k, &price) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn check(tastiness: i32, k: i32, prices: &[i32]) -> bool {
        let mut count = 1;
        let mut last_price = prices[0];

        for i in 1..prices.len() {
            if prices[i] - last_price >= tastiness {
                count += 1;
                last_price = prices[i];
            }
            if count == k {
                return true;
            }
        }
        false
    }
}