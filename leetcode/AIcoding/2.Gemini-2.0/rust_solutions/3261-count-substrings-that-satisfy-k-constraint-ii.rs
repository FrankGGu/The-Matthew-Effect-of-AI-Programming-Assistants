impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i64 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut ans = 0;

        for i in 0..n {
            for j in i..n {
                let mut count = 0;
                for l in i..=j {
                    if s[l] == 'a' || s[l] == 'e' || s[l] == 'i' || s[l] == 'o' || s[l] == 'u' {
                        count += 1;
                    }
                }
                if count >= k {
                    ans += 1;
                }
            }
        }

        ans
    }
}