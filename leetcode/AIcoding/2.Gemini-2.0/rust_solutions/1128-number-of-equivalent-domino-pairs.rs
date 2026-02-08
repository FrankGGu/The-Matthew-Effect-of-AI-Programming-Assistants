use std::collections::HashMap;

impl Solution {
    pub fn num_equiv_domino_pairs(dominoes: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        let mut map: HashMap<(i32, i32), i32> = HashMap::new();
        for domino in dominoes {
            let a = domino[0].min(domino[1]);
            let b = domino[0].max(domino[1]);
            let key = (a, b);
            if map.contains_key(&key) {
                count += map[&key];
                map.insert(key, map[&key] + 1);
            } else {
                map.insert(key, 1);
            }
        }
        count
    }
}