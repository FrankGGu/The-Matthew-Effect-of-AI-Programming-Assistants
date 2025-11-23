struct Solution {}

impl Solution {
    pub fn shortest_distance(
        n: i32,
        edges: Vec<Vec<i32>>,
        queries: Vec<Vec<i32>>,
    ) -> Vec<i32> {
        let n = n as usize;
        let mut dist = vec![vec![i64::MAX / 2; n]; n];

        for i in 0..n {
            dist[i][i] = 0;
        }

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i32;
            dist[u][v] = w as i64;
            dist[v][u] = w as i64;
        }

        for k in 0..n {
            for i in 0..n {
                for j in 0..n {
                    dist[i][j] = dist[i][j].min(dist[i][k] + dist[k][j]);
                }
            }
        }

        let mut ans = vec![];
        for query in &queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2] as i32;

            let mut min_dist = i64::MAX / 2;
            for i in 0..n {
                for j in 0..n {
                    min_dist = min_dist.min(dist[i][j].min((dist[i][u] + w as i64 + dist[v][j]).min(dist[i][v] + w as i64 + dist[u][j])));
                }
            }

            if min_dist >= i64::MAX / 2 {
                ans.push(-1);
            } else {
                ans.push(min_dist as i32);
            }

             let mut new_dist = vec![vec![i64::MAX / 2; n]; n];

            for i in 0..n {
                for j in 0..n {
                    new_dist[i][j] = dist[i][j].min((dist[i][u] + w as i64 + dist[v][j]).min(dist[i][v] + w as i64 + dist[u][j]));
                }
            }

            dist = new_dist;
        }

        ans
    }
}