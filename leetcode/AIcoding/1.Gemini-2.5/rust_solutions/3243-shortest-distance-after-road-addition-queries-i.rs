struct Solution;

impl Solution {
    pub fn shortest_distance_after_road_addition_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = n as usize;
        let inf = std::i64::MAX / 2; // Use MAX / 2 to prevent overflow on addition
        let mut dist: Vec<Vec<i64>> = vec![vec![inf; n]; n];

        for i in 0..n {
            dist[i][i] = 0;
        }

        let mut results: Vec<i64> = Vec::new();

        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2] as i64;

            // Update direct edge weight for the new road
            dist[u][v] = dist[u][v].min(w);
            dist[v][u] = dist[v][u].min(w); // Roads are bidirectional

            // Propagate changes to all-pairs shortest paths
            // This is an O(N^2) update for Floyd-Warshall when an edge is added/reduced.
            // A path from i to j might now be shorter if it goes through the new edge (u,v) or (v,u).
            // Specifically, i -> ... -> u -> v -> ... -> j
            // or i -> ... -> v -> u -> ... -> j
            for i in 0..n {
                for j in 0..n {
                    // Path i -> u -> v -> j
                    if dist[i][u] != inf && dist[v][j] != inf {
                        dist[i][j] = dist[i][j].min(dist[i][u] + dist[u][v] + dist[v][j]);
                    }
                    // Path i -> v -> u -> j
                    if dist[i][v] != inf && dist[u][j] != inf {
                        dist[i][j] = dist[i][j].min(dist[i][v] + dist[v][u] + dist[u][j]);
                    }
                }
            }

            // After all updates, record the shortest path between city 0 and city n-1
            let current_dist = dist[0][n - 1];
            results.push(if current_dist == inf { -1 } else { current_dist });
        }

        results
    }
}