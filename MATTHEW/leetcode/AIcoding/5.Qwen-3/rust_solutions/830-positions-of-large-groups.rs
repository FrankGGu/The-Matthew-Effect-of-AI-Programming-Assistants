struct Solution;

impl Solution {
    pub fn large_groups(s: String) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let s: Vec<char> = s.chars().collect();
        let mut start = 0;

        for i in 1..s.len() {
            if s[i] != s[i - 1] {
                if i - start >= 3 {
                    result.push(vec![start as i32, (i - 1) as i32]);
                }
                start = i;
            }
        }

        if s.len() - start >= 3 {
            result.push(vec![start as i32, (s.len() - 1) as i32]);
        }

        result
    }
}