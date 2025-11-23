use std::collections::HashMap;

impl Solution {
    pub fn num_equiv_domino_pairs(dominoes: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        let mut res = 0;
        for d in dominoes {
            let key = if d[0] < d[1] {
                (d[0], d[1])
            } else {
                (d[1], d[0])
            };
            let &c = count.get(&key).unwrap_or(&0);
            res += c;
            count.insert(key, c + 1);
        }
        res
    }
}