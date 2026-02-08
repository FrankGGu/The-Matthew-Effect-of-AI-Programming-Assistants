impl Solution {
    pub fn min_eating_speed(piles: Vec<i32>, h: i32) -> i32 {
        let mut left = 1;
        let mut right = *piles.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let total: i32 = piles.iter().map(|&x| (x + mid - 1) / mid).sum();

            if total > h {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}