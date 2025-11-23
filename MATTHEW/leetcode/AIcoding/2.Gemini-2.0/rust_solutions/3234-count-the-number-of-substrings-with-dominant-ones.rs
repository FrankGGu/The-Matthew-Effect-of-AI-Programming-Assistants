impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut ans = 0;
        for i in 0..n {
            let mut ones = 0;
            let mut zeros = 0;
            for j in i..n {
                if s[j] == '1' {
                    ones += 1;
                } else {
                    zeros += 1;
                }
                if ones > zeros {
                    ans += 1;
                }
            }
        }
        ans
    }
}