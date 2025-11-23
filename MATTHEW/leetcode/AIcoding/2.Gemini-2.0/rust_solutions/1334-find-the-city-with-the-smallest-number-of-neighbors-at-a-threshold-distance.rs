impl Solution {
    pub fn find_the_city(n: i32, edges: Vec<Vec<i32>>, distance_threshold: i32) -> i32 {
        let n = n as usize;
        let mut dist = vec![vec![i32::MAX; n]; n];
        for i in 0..n {
            dist[i][i] = 0;
        }
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            dist[u][v] = w;
            dist[v][u] = w;
        }

        for k in 0..n {
            for i in 0..n {
                for j in 0..n {
                    if dist[i][k] != i32::MAX && dist[k][j] != i32::MAX && dist[i][k] + dist[k][j] < dist[i][j] {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }

        let mut min_count = i32::MAX;
        let mut result = 0;

        for i in 0..n {
            let mut count = 0;
            for j in 0..n {
                if i != j && dist[i][j] <= distance_threshold {
                    count += 1;
                }
            }
            if count <= min_count {
                min_count = count;
                result = i as i32;
            }
        }

        result
    }
}