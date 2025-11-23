impl Solution {
    pub fn maximum_value(strs: Vec<String>) -> i32 {
        let mut max_val = 0;
        for s in strs {
            let val = if s.chars().all(|c| c.is_digit(10)) {
                s.parse::<i32>().unwrap()
            } else {
                s.len() as i32
            };
            if val > max_val {
                max_val = val;
            }
        }
        max_val
    }
}