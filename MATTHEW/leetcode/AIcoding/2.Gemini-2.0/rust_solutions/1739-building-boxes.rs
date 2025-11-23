impl Solution {
    pub fn minimum_boxes(n: i32) -> i32 {
        let mut k = 0;
        let mut sum = 0;
        while sum < n {
            k += 1;
            sum += k * (k + 1) / 2;
        }
        sum -= k * (k + 1) / 2;
        k -= 1;
        let mut ans = k * (k + 1) / 2;
        let mut i = 1;
        while sum < n {
            sum += i;
            ans += 1;
            i += 1;
        }
        ans
    }
}