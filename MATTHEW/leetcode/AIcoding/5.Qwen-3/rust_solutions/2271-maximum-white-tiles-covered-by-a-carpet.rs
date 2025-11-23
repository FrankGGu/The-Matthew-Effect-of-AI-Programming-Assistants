impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn maximum_white_tiles(mut tiles: Vec<Vec<i32>>, carpet_len: i32) -> i32 {
        tiles.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut res = 0;
        let mut covered = 0;
        let mut i = 0;
        let n = tiles.len();

        while i < n {
            let (start, end) = (tiles[i][0], tiles[i][1]);
            if start + carpet_len <= end {
                return carpet_len;
            }
            if start + carpet_len > end {
                covered += end - start + 1;
                if i + 1 < n && tiles[i + 1][0] <= start + carpet_len {
                    covered += (start + carpet_len - tiles[i + 1][0]) as i32;
                }
                res = res.max(covered);
                covered = 0;
            } else {
                covered += end - start + 1;
                res = res.max(covered);
            }
            i += 1;
        }
        res
    }
}
}