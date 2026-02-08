impl Solution {
    pub fn maximum_value(strs: Vec<String>) -> i32 {
        let mut max_val = 0;
        for s in strs {
            let num = s.parse::<i32>();
            match num {
                Ok(n) => {
                    max_val = max_val.max(n);
                }
                Err(_) => {
                    max_val = max_val.max(s.len() as i32);
                }
            }
        }
        max_val
    }
}