use std::collections::HashMap;

impl Solution {
    pub fn two_sum(prices: Vec<i32>, target: i32) -> Vec<i32> {
        let mut map: HashMap<i32, i32> = HashMap::new();
        for (i, &price) in prices.iter().enumerate() {
            let complement = target - price;
            if let Some(&complement_index) = map.get(&complement) {
                return vec![complement_index, i as i32];
            }
            map.insert(price, i as i32);
        }
        unreachable!()
    }
}