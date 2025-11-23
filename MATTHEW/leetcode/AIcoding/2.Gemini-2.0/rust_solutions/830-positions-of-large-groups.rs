impl Solution {
    pub fn large_group_positions(s: String) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let s_bytes = s.as_bytes();
        let mut start = 0;
        let mut count = 1;

        for i in 1..s_bytes.len() {
            if s_bytes[i] == s_bytes[i - 1] {
                count += 1;
            } else {
                if count >= 3 {
                    result.push(vec![start as i32, (i - 1) as i32]);
                }
                start = i;
                count = 1;
            }
        }

        if count >= 3 {
            result.push(vec![start as i32, (s_bytes.len() - 1) as i32]);
        }

        result
    }
}