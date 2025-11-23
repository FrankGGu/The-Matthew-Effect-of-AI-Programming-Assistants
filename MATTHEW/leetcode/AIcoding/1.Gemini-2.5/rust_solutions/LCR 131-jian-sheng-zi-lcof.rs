use std::collections::HashSet;

impl Solution {
    pub fn cut_bamboo(bamboo_heights: Vec<i32>) -> i32 {
        if bamboo_heights.is_empty() {
            return 0;
        }

        let mut unique_heights = HashSet::new();
        for height in bamboo_heights {
            unique_heights.insert(height);
        }

        (unique_heights.len() - 1) as i32
    }
}