impl Solution {
    pub fn equal_substring(s: String, t: String, max_cost: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut costs: Vec<i32> = Vec::with_capacity(n);
        for i in 0..n {
            costs.push((s_bytes[i] as i32 - t_bytes[i] as i32).abs());
        }

        let mut left = 0;
        let mut current_cost = 0;
        let mut max_len = 0;

        for right in 0..n {
            current_cost += costs[right];

            while current_cost > max_cost {
                current_cost -= costs[left];
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}