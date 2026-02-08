impl Solution {
    pub fn maximum_value(strs: Vec<String>) -> i32 {
        let mut max_val = 0;

        for s in strs {
            let current_val = match s.parse::<i32>() {
                Ok(val) => val,
                Err(_) => s.len() as i32,
            };
            max_val = max_val.max(current_val);
        }

        max_val
    }
}