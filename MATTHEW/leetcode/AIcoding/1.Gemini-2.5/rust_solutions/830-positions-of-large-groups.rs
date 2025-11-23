impl Solution {
    pub fn large_group_positions(s: String) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if s.is_empty() {
            return result;
        }

        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut start_index = 0;

        for i in 0..=n {
            if i == n || s_bytes[i] != s_bytes[start_index] {
                let length = i - start_index;
                if length >= 3 {
                    result.push(vec![start_index as i32, (i - 1) as i32]);
                }
                start_index = i;
            }
        }
        result
    }
}