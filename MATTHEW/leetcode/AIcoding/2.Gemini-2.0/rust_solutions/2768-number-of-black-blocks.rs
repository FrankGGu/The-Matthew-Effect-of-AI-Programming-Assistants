use std::collections::HashMap;

impl Solution {
    pub fn count_black_blocks(n: i32, m: i32, coordinates: Vec<Vec<i32>>) -> Vec<i64> {
        let mut counts = vec![0; 5];
        let mut block_counts: HashMap<(i32, i32), i32> = HashMap::new();

        for coord in coordinates {
            let row = coord[0];
            let col = coord[1];

            for i in -1..1 {
                for j in -1..1 {
                    let r = row + i;
                    let c = col + j;

                    if r > 0 && r < n && c > 0 && c < m {
                        *block_counts.entry((r, c)).or_insert(0) += 1;
                    }
                }
            }
        }

        for &count in block_counts.values() {
            counts[count as usize] += 1;
        }

        let total_blocks = (n as i64 - 1) * (m as i64 - 1);
        counts[0] = total_blocks - counts[1] - counts[2] - counts[3] - counts[4];

        counts
    }
}