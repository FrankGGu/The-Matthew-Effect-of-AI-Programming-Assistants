impl Solution {
    pub fn large_group_positions(s: String) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let chars: Vec<char> = s.chars().collect();
        let mut start = 0;

        for end in 1..chars.len() {
            if chars[end] != chars[start] {
                if end - start >= 3 {
                    result.push(vec![start as i32, (end - 1) as i32]);
                }
                start = end;
            }
        }

        if chars.len() - start >= 3 {
            result.push(vec![start as i32, (chars.len() - 1) as i32]);
        }

        result
    }
}