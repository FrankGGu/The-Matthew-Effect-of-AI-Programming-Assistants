impl Solution {
    pub fn maximum_white_tiles(tiles: Vec<Vec<i32>>, carpet_len: i32) -> i32 {
        let mut tiles = tiles;
        tiles.sort_unstable();
        let n = tiles.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + (tiles[i][1] - tiles[i][0] + 1);
        }
        let mut res = 0;
        for i in 0..n {
            let start = tiles[i][0];
            let end = start + carpet_len - 1;
            let j = match tiles.binary_search_by(|x| x[0].cmp(&end).then(std::cmp::Ordering::Greater)) {
                Ok(pos) => pos,
                Err(pos) => pos - 1,
            };
            let mut covered = prefix[j] - prefix[i];
            if j < n && tiles[j][1] <= end {
                covered += end - tiles[j][0] + 1;
            } else if j < n {
                covered += tiles[j][1] - tiles[j][0] + 1;
            }
            res = res.max(covered);
        }
        res
    }
}