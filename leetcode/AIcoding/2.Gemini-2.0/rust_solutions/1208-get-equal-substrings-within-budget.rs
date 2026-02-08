impl Solution {
    pub fn equal_substring(s: String, t: String, max_cost: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s.len();
        let mut left = 0;
        let mut right = 0;
        let mut current_cost = 0;
        let mut max_len = 0;

        while right < n {
            current_cost += (s_bytes[right] as i32 - t_bytes[right] as i32).abs();

            while current_cost > max_cost {
                current_cost -= (s_bytes[left] as i32 - t_bytes[left] as i32).abs();
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
            right += 1;
        }

        max_len
    }
}