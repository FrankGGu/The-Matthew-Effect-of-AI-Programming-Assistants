impl Solution {
    pub fn maximum_tastiness(price: Vec<i32>, k: i32) -> i32 {
        let mut price = price;
        price.sort();
        let (mut low, mut high) = (1, price.last().unwrap() - price[0]);

        while low < high {
            let mid = low + (high - low) / 2;
            if Self::can_select(&price, mid, k) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        low - 1
    }

    fn can_select(price: &[i32], min_diff: i32, k: i32) -> bool {
        let mut count = 1;
        let mut last_selected = price[0];

        for &p in price.iter().skip(1) {
            if p - last_selected >= min_diff {
                count += 1;
                last_selected = p;
            }
            if count >= k {
                return true;
            }
        }

        count >= k
    }
}