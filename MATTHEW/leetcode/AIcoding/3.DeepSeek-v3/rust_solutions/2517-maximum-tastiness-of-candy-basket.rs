impl Solution {
    pub fn maximum_tastiness(mut price: Vec<i32>, k: i32) -> i32 {
        price.sort();
        let n = price.len();
        let mut left = 0;
        let mut right = price[n - 1] - price[0];

        while left < right {
            let mid = left + (right - left + 1) / 2;
            if Self::is_possible(&price, mid, k) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        left
    }

    fn is_possible(price: &[i32], target: i32, k: i32) -> bool {
        let mut count = 1;
        let mut last = price[0];
        for &p in price.iter().skip(1) {
            if p - last >= target {
                count += 1;
                last = p;
                if count >= k {
                    return true;
                }
            }
        }
        count >= k
    }
}