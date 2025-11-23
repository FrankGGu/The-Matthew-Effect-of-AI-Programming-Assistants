impl Solution {
    pub fn minimum_operations(num: String) -> i32 {
        let n = num.len();
        let bytes = num.as_bytes();
        let mut ans = n as i32;
        for i in 0..n {
            for j in i + 1..n {
                let val = (bytes[i] - b'0') * 10 + (bytes[j] - b'0');
                if val % 25 == 0 {
                    ans = ans.min((n - 1 - j) as i32 + (j - i - 1) as i32);
                }
            }
        }
        ans
    }
}