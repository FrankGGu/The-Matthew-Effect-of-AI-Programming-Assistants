impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_coins(fruits: Vec<i32>, coins: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for i in 0..fruits.len() {
            map.insert(fruits[i], coins[i]);
        }
        let mut sorted = fruits.clone();
        sorted.sort();
        let mut res = 0;
        let mut prev = 0;
        for &f in &sorted {
            if f > prev {
                res += map[&f];
                prev = f;
            }
        }
        res
    }
}
}