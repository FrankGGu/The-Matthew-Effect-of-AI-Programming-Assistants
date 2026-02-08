impl Solution {
    pub fn arrange_coins(n: i32) -> i32 {
        let mut left = 1;
        let mut right = n;
        let mut k = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let coins = mid * (mid + 1) / 2;

            if coins == n {
                return mid;
            } else if coins < n {
                k = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        k
    }
}