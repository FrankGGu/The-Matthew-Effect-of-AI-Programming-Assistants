impl Solution {
    pub fn k_th_nearest_obstacle_queries(obstacles: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let qx = query[0] as i64;
            let qy = query[1] as i64;
            let k = query[2] as usize;

            let mut distances_sq = Vec::with_capacity(obstacles.len());
            for obstacle in &obstacles {
                let ox = obstacle[0] as i64;
                let oy = obstacle[1] as i64;

                let dx = qx - ox;
                let dy = qy - oy;
                let dist_sq = dx * dx + dy * dy;
                distances_sq.push(dist_sq);
            }

            distances_sq.sort_unstable();

            results.push(distances_sq[k - 1]);
        }

        results
    }
}