impl Solution {
    pub fn flipgame(fronts: Vec<i32>, backs: Vec<i32>) -> i32 {
        use std::collections::HashSet;

        let n = fronts.len();
        let mut invalid = HashSet::new();

        for i in 0..n {
            if fronts[i] == backs[i] {
                invalid.insert(fronts[i]);
            }
        }

        let mut min_valid = i32::MAX;

        for i in 0..n {
            if !invalid.contains(&fronts[i]) {
                min_valid = min_valid.min(fronts[i]);
            }
            if !invalid.contains(&backs[i]) {
                min_valid = min_valid.min(backs[i]);
            }
        }

        if min_valid == i32::MAX {
            0
        } else {
            min_valid
        }
    }
}