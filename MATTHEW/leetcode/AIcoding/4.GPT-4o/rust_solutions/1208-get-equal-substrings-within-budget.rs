impl Solution {
    pub fn equal_substring(s: String, t: String, max_cost: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let mut left = 0;
        let mut total_cost = 0;
        let mut max_length = 0;

        for right in 0..s.len() {
            total_cost += (s_bytes[right] as i32 - t_bytes[right] as i32).abs();
            while total_cost > max_cost {
                total_cost -= (s_bytes[left] as i32 - t_bytes[left] as i32).abs();
                left += 1;
            }
            max_length = max_length.max(right - left + 1);
        }

        max_length
    }
}