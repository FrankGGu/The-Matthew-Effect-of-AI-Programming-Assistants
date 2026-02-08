impl Solution {
    pub fn check_balanced_string(s: String) -> i32 {
        let n = s.len();
        let k = n / 4;
        let mut count = std::collections::HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut ans = n as i32;
        let mut left = 0;
        for right in 0..n {
            *count.entry(s.chars().nth(right).unwrap()).or_insert(0) -= 1;

            while *count.get(&'Q').unwrap_or(&0) <= k as i32 &&
                  *count.get(&'W').unwrap_or(&0) <= k as i32 &&
                  *count.get(&'E').unwrap_or(&0) <= k as i32 &&
                  *count.get(&'R').unwrap_or(&0) <= k as i32 {
                ans = ans.min((right - left + 1) as i32);
                *count.entry(s.chars().nth(left).unwrap()).or_insert(0) += 1;
                left += 1;
            }
        }

        ans
    }
}