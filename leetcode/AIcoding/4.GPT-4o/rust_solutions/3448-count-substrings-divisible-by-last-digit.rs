impl Solution {
    pub fn count_divisible_substrings(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut count = 0;

        for i in 0..n {
            let mut num = 0;
            for j in i..n {
                num = num * 10 + (bytes[j] - b'0') as i32;
                if j == n - 1 || bytes[j + 1] == b'0' {
                    break;
                }
                if num % (bytes[j] - b'0') as i32 == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}