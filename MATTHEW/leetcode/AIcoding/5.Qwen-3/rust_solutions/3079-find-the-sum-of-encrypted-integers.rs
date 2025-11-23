impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_of_encrypted_int(nums: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for num in nums {
            let s = num.to_string();
            let encrypted = s.chars().map(|c| '9').collect::<String>();
            let key = encrypted.len() as i32;
            let value = map.entry(key).or_insert(0);
            *value += num;
        }
        map.values().sum()
    }
}
}