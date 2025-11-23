impl Solution {
    pub fn minimum_perimeter(needed_apples: i64) -> i64 {
        let mut low: i64 = 0;
        let mut high: i64 = 100000;
        let mut ans: i64 = 0;

        while low <= high {
            let mid: i64 = low + (high - low) / 2;
            let apples: i64 = 2 * mid * (mid + 1) * (2 * mid + 1);

            if apples >= needed_apples {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans * 8
    }
}