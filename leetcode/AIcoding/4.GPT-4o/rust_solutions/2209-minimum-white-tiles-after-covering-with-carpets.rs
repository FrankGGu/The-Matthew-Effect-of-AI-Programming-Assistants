impl Solution {
    pub fn minimum_white_tiles(tiles: Vec<i32>, carpet_len: i32) -> i32 {
        let n = tiles.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + tiles[i];
        }

        let mut left = 0;
        let mut right = 0;
        let mut min_white = prefix_sum[n];

        while right < n {
            while right < n && (right == left || tiles[right] <= carpet_len) {
                right += 1;
            }
            let total_cover = if right > left {
                prefix_sum[right] - prefix_sum[left]
            } else {
                0
            };
            min_white = min_white.min(prefix_sum[n] - total_cover);
            left += 1;
        }

        min_white
    }
}