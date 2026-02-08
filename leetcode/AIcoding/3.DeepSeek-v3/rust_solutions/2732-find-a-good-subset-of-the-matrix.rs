impl Solution {
    pub fn good_subset_of_binary_matrix(grid: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::HashMap;
        let n = grid.len();
        let m = grid[0].len();
        let mut map = HashMap::new();

        for (i, row) in grid.iter().enumerate() {
            let mut mask = 0;
            for (j, &val) in row.iter().enumerate() {
                if val == 1 {
                    mask |= 1 << j;
                }
            }
            if mask == 0 {
                return vec![i as i32];
            }
            map.insert(mask, i as i32);
        }

        for (&mask1, &i) in map.iter() {
            for (&mask2, &j) in map.iter() {
                if (mask1 & mask2) == 0 {
                    let mut res = vec![i, j];
                    res.sort();
                    return res;
                }
            }
        }

        vec![]
    }
}