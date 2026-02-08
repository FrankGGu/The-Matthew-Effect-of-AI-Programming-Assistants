use std::collections::HashMap;

impl Solution {
    pub fn longest_wpi(hours: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut balance = 0;
        let mut balance_map: HashMap<i32, usize> = HashMap::new();
        balance_map.insert(0, -1 as usize);

        for i in 0..hours.len() {
            if hours[i] > 8 {
                balance += 1;
            } else {
                balance -= 1;
            }

            if balance > 0 {
                max_len = max_len.max((i + 1) as i32);
            } else {
                if !balance_map.contains_key(&balance) {
                    balance_map.insert(balance, i);
                }

                if balance_map.contains_key(&(balance - 1)) {
                    max_len = max_len.max((i - balance_map.get(&(balance - 1)).unwrap()) as i32);
                }
            }
        }

        max_len
    }
}