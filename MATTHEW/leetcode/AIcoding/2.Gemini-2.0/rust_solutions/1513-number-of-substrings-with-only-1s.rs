impl Solution {
    pub fn num_sub(s: String) -> i32 {
        let mut count = 0;
        let mut ans = 0;
        for c in s.chars() {
            if c == '1' {
                count += 1;
                ans = (ans + count) % 1000000007;
            } else {
                count = 0;
            }
        }
        ans
    }
}