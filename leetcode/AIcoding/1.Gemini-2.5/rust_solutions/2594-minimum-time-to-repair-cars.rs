impl Solution {
    pub fn minimum_time_to_repair_cars(ranks: Vec<i32>, n: i32) -> i64 {
        let mut low: i64 = 0;
        let mut high: i64 = 1_000_000_000_000_000;
        let mut ans: i64 = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &ranks, n) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn check(target_time: i64, ranks: &[i32], n: i32) -> bool {
        let mut total_cars_repaired: i64 = 0;
        for &rank in ranks {
            let val_for_sqrt = target_time / (rank as i64);
            let cars_for_this_mechanic = (val_for_sqrt as f64).sqrt() as i64;

            total_cars_repaired += cars_for_this_mechanic;

            if total_cars_repaired >= n as i64 {
                return true;
            }
        }
        total_cars_repaired >= n as i64
    }
}