use std::collections::HashSet;

impl Solution {
    pub fn flipgame(fronts: Vec<i32>, backs: Vec<i32>) -> i32 {
        let mut same = HashSet::new();
        for i in 0..fronts.len() {
            if fronts[i] == backs[i] {
                same.insert(fronts[i]);
            }
        }
        let mut res = i32::MAX;
        for &num in fronts.iter().chain(backs.iter()) {
            if !same.contains(&num) {
                res = res.min(num);
            }
        }
        if res == i32::MAX { 0 } else { res }
    }
}