impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_black_blocks(n: i32, m: i32, cells: Vec<Vec<i32>>) -> Vec<i32> {
        let mut block_count = HashMap::new();
        let mut result = vec![];

        for cell in cells {
            let (r, c) = (cell[0], cell[1]);
            for dr in [-1, 0] {
                for dc in [-1, 0] {
                    let br = r + dr;
                    let bc = c + dc;
                    if br >= 0 && br < n && bc >= 0 && bc < m {
                        let key = (br, bc);
                        *block_count.entry(key).or_insert(0) += 1;
                    }
                }
            }
        }

        for count in block_count.values() {
            if *count >= 4 {
                result.push(*count);
            }
        }

        result.sort_unstable();
        result
    }
}
}