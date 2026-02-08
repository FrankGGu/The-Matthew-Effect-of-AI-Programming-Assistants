impl Solution {
    pub fn count_black_blocks(m: i32, n: i32, coordinates: Vec<Vec<i32>>) -> Vec<i64> {
        use std::collections::HashMap;

        let mut blocks = HashMap::new();
        for coord in coordinates {
            let x = coord[0];
            let y = coord[1];
            for i in (x - 1).max(0)..=x {
                for j in (y - 1).max(0)..=y {
                    if i + 1 < m && j + 1 < n {
                        let key = (i, j);
                        *blocks.entry(key).or_insert(0) += 1;
                    }
                }
            }
        }

        let mut res = vec![0; 5];
        for &cnt in blocks.values() {
            res[cnt as usize] += 1;
        }

        let total = (m as i64 - 1) * (n as i64 - 1);
        res[0] = total - res[1] - res[2] - res[3] - res[4];
        res
    }
}