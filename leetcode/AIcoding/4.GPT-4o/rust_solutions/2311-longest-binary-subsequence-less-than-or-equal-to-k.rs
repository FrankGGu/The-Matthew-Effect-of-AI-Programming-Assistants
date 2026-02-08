impl Solution {
    pub fn longest_binary_subsequence(s: String, k: i64) -> i32 {
        let mut count = 0;
        let mut num = 0;
        let mut pow = 1;

        for ch in s.chars().rev() {
            if ch == '1' {
                num += pow;
            }
            if num <= k {
                count += 1;
            } else if ch == '0' {
                count += 1;
            }
            pow *= 2;
        }

        count
    }
}