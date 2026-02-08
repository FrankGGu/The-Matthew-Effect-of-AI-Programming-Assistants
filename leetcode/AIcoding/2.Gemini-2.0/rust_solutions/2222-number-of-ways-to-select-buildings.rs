impl Solution {
    pub fn number_of_ways(s: String) -> i64 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut ans = 0;
        for i in 1..n - 1 {
            let mut left_zeros = 0;
            let mut left_ones = 0;
            for j in 0..i {
                if s[j] == '0' {
                    left_zeros += 1;
                } else {
                    left_ones += 1;
                }
            }
            let mut right_zeros = 0;
            let mut right_ones = 0;
            for j in i + 1..n {
                if s[j] == '0' {
                    right_zeros += 1;
                } else {
                    right_ones += 1;
                }
            }
            if s[i] == '0' {
                ans += left_ones * right_ones;
            } else {
                ans += left_zeros * right_zeros;
            }
        }
        ans as i64
    }
}