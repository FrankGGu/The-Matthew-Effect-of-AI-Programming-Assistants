impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_ways(street: String) -> i32 {
        let mut count = 0;
        let mut positions = Vec::new();
        for (i, c) in street.chars().enumerate() {
            if c == 'S' {
                positions.push(i);
                count += 1;
            }
        }
        if count % 2 != 0 {
            return 0;
        }
        let mut result = 1;
        let mut prev = 0;
        for i in 0..positions.len() / 2 {
            let start = positions[2 * i];
            let end = positions[2 * i + 1];
            let gap = positions[2 * i + 2] - end;
            result = result * gap % 1000000007;
        }
        result
    }
}
}