impl Solution {
    pub fn maximum_white_tiles(tiles: Vec<Vec<i32>>, carpet_len: i32) -> i32 {
        let mut tiles = tiles;
        tiles.sort_by_key(|tile| tile[0]);
        let n = tiles.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + (tiles[i][1] - tiles[i][0] + 1);
        }

        let mut max_covered = 0;
        for i in 0..n {
            let start = tiles[i][0];
            let end = start + carpet_len - 1;
            let j = match tiles.binary_search_by(|tile| tile[0].cmp(&end)) {
                Ok(j) => j,
                Err(j) => j - 1,
            };

            let mut covered = prefix_sum[j + 1] - prefix_sum[i];
            if j >= 0 {
                covered = covered.max(0);
            }

            let last_tile_start = tiles[j][0];
            let last_tile_end = tiles[j][1];

            if last_tile_end > end {
                covered += (end - last_tile_start + 1).max(0);
            } else {
                covered += (last_tile_end - last_tile_start + 1).max(0);
            }

            max_covered = max_covered.max(covered);
        }

        max_covered
    }
}