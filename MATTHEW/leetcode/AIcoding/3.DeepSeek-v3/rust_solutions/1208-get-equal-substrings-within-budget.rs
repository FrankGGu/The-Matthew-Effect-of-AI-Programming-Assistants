impl Solution {
    pub fn equal_substring(s: String, t: String, max_cost: i32) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let n = s_chars.len();
        let mut cost = vec![0; n];
        for i in 0..n {
            cost[i] = (s_chars[i] as i32 - t_chars[i] as i32).abs();
        }

        let mut left = 0;
        let mut current_cost = 0;
        let mut max_len = 0;

        for right in 0..n {
            current_cost += cost[right];
            while current_cost > max_cost {
                current_cost -= cost[left];
                left += 1;
            }
            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}