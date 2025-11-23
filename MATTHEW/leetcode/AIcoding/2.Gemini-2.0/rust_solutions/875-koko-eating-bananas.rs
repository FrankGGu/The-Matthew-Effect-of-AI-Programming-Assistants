impl Solution {
    pub fn min_eating_speed(piles: Vec<i32>, h: i32) -> i32 {
        let mut left = 1;
        let mut right = *piles.iter().max().unwrap();
        let mut ans = right;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut time = 0;
            for &pile in &piles {
                time += (pile + mid - 1) / mid;
            }

            if time <= h {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}