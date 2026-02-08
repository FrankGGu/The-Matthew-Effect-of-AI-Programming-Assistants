impl Solution {
    pub fn maximum_costSubstring(s: String, chars: String, vals: Vec<i32>) -> i32 {
        let mut char_cost = std::collections::HashMap::new();
        for (c, v) in chars.chars().zip(vals) {
            char_cost.insert(c, v);
        }

        let mut max_cost = 0;
        let mut current_cost = 0;

        for ch in s.chars() {
            current_cost += char_cost.get(&ch).unwrap_or(&-1);
            if current_cost < 0 {
                current_cost = 0;
            }
            max_cost = max_cost.max(current_cost);
        }

        max_cost
    }
}