impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_be_equal(mut target: String, mut nuke: String) -> bool {
        let mut count = HashMap::new();

        for c in target.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        for c in nuke.chars() {
            *count.entry(c).or_insert(0) -= 1;
        }

        for &v in count.values() {
            if v != 0 {
                return false;
            }
        }

        true
    }
}
}