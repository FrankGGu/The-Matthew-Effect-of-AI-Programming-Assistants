struct Solution;

impl Solution {
    pub fn maximum_manhattan_distance(points: Vec<Vec<i32>>, k: i32) -> i64 {
        let n = points.len();
        let k_usize = k as usize;

        if n <= k_usize {
            return 0;
        }

        let required_points = n - k_usize;

        let mut u_coords: Vec<i64> = Vec::with_capacity(n);
        let mut v_coords: Vec<i64> = Vec::with_capacity(n);

        for point in points {
            u_coords.push(point[0] as i64 + point[1] as i64);
            v_coords.push(point[0] as i64 - point[1] as i64);
        }

        let mut max_dist = 0;

        max_dist = max_dist.max(Self::calculate_max_diff(u_coords, required_points));
        max_dist = max_dist.max(Self::calculate_max_diff(v_coords, required_points));

        max_dist
    }

    fn calculate_max_diff(mut coords: Vec<i64>, required_points: usize) -> i64 {
        let n = coords.len();

        if required_points <= 1 {
            return 0;
        }

        coords.sort_unstable();

        let mut max_diff = 0;
        let mut min_prefix_vals = vec![0; n];
        min_prefix_vals[0] = coords[0];
        for i in 1..n {
            min_prefix_vals[i] = min_prefix_vals[i-1].min(coords[i]);
        }

        for j in (required_points - 1)..n {
            let min_idx = j - required_points + 1;
            max_diff = max_diff.max(coords[j] - min_prefix_vals[min_idx]);
        }

        max_diff
    }
}