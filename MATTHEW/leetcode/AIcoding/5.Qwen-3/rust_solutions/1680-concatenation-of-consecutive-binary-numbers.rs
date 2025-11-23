impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let mut result = 0;
        let mut length = 0;
        for i in 1..=n {
            if (i & (i - 1)) == 0 {
                length += 1;
            }
            result = (result << length) | i;
            result %= 1000000007;
        }
        result
    }
}