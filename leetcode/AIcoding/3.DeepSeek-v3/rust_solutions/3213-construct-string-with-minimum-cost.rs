impl Solution {
    pub fn minimum_cost(s: String) -> i64 {
        let s = s.chars().collect::<Vec<char>>();
        let n = s.len();
        let mut res = 0;

        for i in 1..n {
            if s[i] != s[i - 1] {
                res += std::cmp::min(i, n - i) as i64;
            }
        }

        res
    }
}