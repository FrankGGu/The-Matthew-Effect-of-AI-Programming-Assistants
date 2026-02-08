impl Solution {
    pub fn minimized_maximum(n: i32, quantities: Vec<i32>) -> i32 {
        let mut low = 1;
        let mut high = *quantities.iter().max().unwrap();
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut stores_needed = 0;
            for &q in quantities.iter() {
                stores_needed += (q + mid - 1) / mid;
            }

            if stores_needed <= n {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }
}