impl Solution {
    pub fn minimized_maximum(n: i32, quantities: Vec<i32>) -> i32 {
        let mut left = 1;
        let mut right = *quantities.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut stores_needed = 0;

            for &q in &quantities {
                stores_needed += (q + mid - 1) / mid;
            }

            if stores_needed > n {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}