pub fn maximum_white_tiles(tiles: Vec<Vec<i32>>, carpet_len: i32) -> i32 {
    let mut tiles = tiles;
    tiles.sort_unstable();
    let n = tiles.len();
    let mut prefix_sum = vec![0; n + 1];

    for i in 0..n {
        prefix_sum[i + 1] = prefix_sum[i] + (tiles[i][1] - tiles[i][0] + 1);
    }

    let mut max_tiles = 0;
    let mut j = 0;

    for i in 0..n {
        while j < n && tiles[j][0] - tiles[i][0] < carpet_len {
            j += 1;
        }
        let covered_length = if j == n {
            prefix_sum[j] - prefix_sum[i]
        } else {
            let excess = (tiles[j][0] - tiles[i][0]) - carpet_len;
            if excess > 0 {
                prefix_sum[j] - prefix_sum[i] - excess
            } else {
                prefix_sum[j] - prefix_sum[i]
            }
        };
        max_tiles = max_tiles.max(covered_length);
    }

    max_tiles
}