use std::collections::HashMap;

impl Solution {
    pub fn two_sum(numbers: Vec<i32>, target: i32) -> Vec<i32> {
        let mut map = HashMap::new();
        for (i, &num) in numbers.iter().enumerate() {
            let complement = target - num;
            if let Some(&j) = map.get(&complement) {
                return vec![j as i32 + 1, i as i32 + 1];
            }
            map.insert(num, i);
        }
        vec![]
    }
}