impl Solution {
    pub fn last_remaining(n: i32, m: i32) -> i32 {
        let mut ans = 0;
        for i in 2..=n {
            ans = (ans + m) % i;
        }
        ans
    }
}