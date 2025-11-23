impl Solution {
    pub fn maximum_tastiness(price: Vec<i32>, k: i32) -> i32 {
        let mut price = price;
        price.sort();

        let mut low = 0;
        let mut high = price[price.len() - 1] - price[0];
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::is_possible(&price, k, mid) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }

    fn is_possible(price: &Vec<i32>, k: i32, tastiness: i32) -> bool {
        let mut count = 1;
        let mut prev = price[0];

        for i in 1..price.len() {
            if price[i] - prev >= tastiness {
                count += 1;
                prev = price[i];
            }
        }

        count >= k
    }
}