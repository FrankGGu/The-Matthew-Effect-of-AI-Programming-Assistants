impl Solution {
    pub fn minimum_cost(s: String) -> i64 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut res = 0i64;

        for i in 1..n {
            if chars[i] != chars[i - 1] {
                res += std::cmp::min(i as i64, (n - i) as i64);
            }
        }

        res
    }
}