impl Solution {
    pub fn minimize_manhattan_distances(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();

        let mut u_indexed: Vec<(i64, usize)> = Vec::with_capacity(n);
        let mut v_indexed: Vec<(i64, usize)> = Vec::with_capacity(n);

        for (i, p) in points.iter().enumerate() {
            let x = p[0] as i64;
            let y = p[1] as i64;
            u_indexed.push((x + y, i));
            v_indexed.push((x - y, i));
        }

        u_indexed.sort_unstable_by_key(|&(val, _)| val);
        v_indexed.sort_unstable_by_key(|&(val, _)| val);

        let mut min_overall_max_dist = i64::MAX;

        for k in 0..n {
            let current_min_u;
            let current_max_u;
            let current_min_v;
            let current_max_v;

            if u_indexed[0].1 == k {
                current_min_u = u_indexed[1].0;
            } else {
                current_min_u = u_indexed[0].0;
            }

            if u_indexed[n - 1].1 == k {
                current_max_u = u_indexed[n - 2].0;
            } else {
                current_max_u = u_indexed[n - 1].0;
            }
            let u_range = current_max_u - current_min_u;

            if v_indexed[0].1 == k {
                current_min_v = v_indexed[1].0;
            } else {
                current_min_v = v_indexed[0].0;
            }

            if v_indexed[n - 1].1 == k {
                current_max_v = v_indexed[n - 2].0;
            } else {
                current_max_v = v_indexed[n - 1].0;
            }
            let v_range = current_max_v - current_min_v;

            min_overall_max_dist = min_overall_max_dist.min(u_range.max(v_range));
        }

        min_overall_max_dist as i32
    }
}