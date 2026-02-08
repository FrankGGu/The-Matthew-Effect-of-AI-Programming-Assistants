impl Solution {
    pub fn longest_semi_repetitive_substring(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut ans = 0;
        for i in 0..n {
            for j in i..n {
                let sub: Vec<char> = s[i..=j].to_vec();
                let mut count = 0;
                for k in 0..sub.len() - 1 {
                    if sub[k] == sub[k + 1] {
                        count += 1;
                    }
                }
                if count <= 1 {
                    ans = ans.max((j - i + 1) as i32);
                }
            }
        }
        ans
    }
}