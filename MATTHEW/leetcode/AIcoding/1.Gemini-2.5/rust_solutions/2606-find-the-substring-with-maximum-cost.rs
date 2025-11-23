impl Solution {
    pub fn max_cost_substring(s: String, chars_cost: String, vals: Vec<i32>) -> i32 {
        let mut char_costs: Vec<i32> = (1..=26).collect(); // Default costs 'a'=1, 'b'=2, ...

        for (i, c) in chars_cost.chars().enumerate() {
            char_costs[(c as u8 - b'a') as usize] = vals[i];
        }

        let mut current_max_cost: i64 = 0;
        let mut global_max_cost: i64 = 0;

        for c in s.chars() {
            let cost = char_costs[(c as u8 - b'a') as usize] as i64;
            current_max_cost = current_max_cost + cost;
            if current_max_cost < 0 {
                current_max_cost = 0;
            }
            global_max_cost = global_max_cost.max(current_max_cost);
        }

        global_max_cost as i32
    }
}