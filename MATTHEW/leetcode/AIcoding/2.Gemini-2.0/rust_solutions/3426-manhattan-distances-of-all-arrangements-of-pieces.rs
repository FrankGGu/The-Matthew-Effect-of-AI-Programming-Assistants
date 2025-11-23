impl Solution {
    pub fn manhattan_distances(pieces: Vec<Vec<i32>>) -> Vec<i64> {
        let n = pieces.len();
        let mut x_coords: Vec<i32> = pieces.iter().map(|p| p[0]).collect();
        let mut y_coords: Vec<i32> = pieces.iter().map(|p| p[1]).collect();

        x_coords.sort();
        y_coords.sort();

        let mut x_prefix_sum: Vec<i64> = vec![0; n + 1];
        let mut y_prefix_sum: Vec<i64> = vec![0; n + 1];

        for i in 0..n {
            x_prefix_sum[i + 1] = x_prefix_sum[i] + x_coords[i] as i64;
            y_prefix_sum[i + 1] = y_prefix_sum[i] + y_coords[i] as i64;
        }

        let mut ans: Vec<i64> = vec![0; n];

        for i in 0..n {
            let x = pieces[i][0];
            let y = pieces[i][1];

            let x_rank = x_coords.binary_search(&x).unwrap();
            let y_rank = y_coords.binary_search(&y).unwrap();

            let x_left_sum = x_prefix_sum[x_rank] as i64;
            let x_right_sum = x_prefix_sum[n] - x_prefix_sum[x_rank + 1];

            let y_left_sum = y_prefix_sum[y_rank] as i64;
            let y_right_sum = y_prefix_sum[n] - y_prefix_sum[y_rank + 1];

            let x_left_count = x_rank as i64;
            let x_right_count = (n - x_rank - 1) as i64;

            let y_left_count = y_rank as i64;
            let y_right_count = (n - y_rank - 1) as i64;

            let x_dist = x as i64 * x_left_count - x_left_sum + x_right_sum - x as i64 * x_right_count;
            let y_dist = y as i64 * y_left_count - y_left_sum + y_right_sum - y as i64 * y_right_count;

            ans[i] = x_dist + y_dist;
        }

        ans
    }
}