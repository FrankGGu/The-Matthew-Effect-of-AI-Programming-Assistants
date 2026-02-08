struct Solution;

impl Solution {
    pub fn shortest_distance_after_road_addition_queries(
        n: i32,
        initial_roads: Vec<Vec<i32>>,
        queries: Vec<Vec<i32>>,
    ) -> Vec<i64> {
        let n = n as usize;
        let infinity = 1_000_000_000_000_000_i64;

        let mut dist: Vec<Vec<i64>> = vec![vec![infinity; n]; n];

        for i in 0..n {
            dist[i][i] = 0;
        }

        for road in initial_roads {
            let u = road[0] as usize - 1;
            let v = road[1] as usize - 1;
            let w = road[2] as i64;
            dist[u][v] = dist[u][v].min(w);
            dist[v][u] = dist[v][u].min(w);
        }

        for k in 0..n {
            for i in 0..n {
                for j in 0..n {
                    if dist[i][k] != infinity && dist[k][j] != infinity {
                        dist[i][j] = dist[i][j].min(dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        let mut results = Vec::new();

        for query in queries {
            if query.len() == 3 {
                let u_new = query[0] as usize - 1;
                let v_new = query[1] as usize - 1;
                let w_new = query[2] as i64;

                dist[u_new][v_new] = dist[u_new][v_new].min(w_new);
                dist[v_new][u_new] = dist[v_new][u_new].min(w_new);

                for i in 0..n {
                    for j in 0..n {
                        if dist[i][u_new] != infinity && dist[v_new][j] != infinity {
                            dist[i][j] = dist[i][j].min(dist[i][u_new] + w_new + dist[v_new][j]);
                        }
                        if dist[i][v_new] != infinity && dist[u_new][j] != infinity {
                            dist[i][j] = dist[i][j].min(dist[i][v_new] + w_new + dist[u_new][j]);
                        }
                    }
                }
            } else {
                let u_query = query[0] as usize - 1;
                let v_query = query[1] as usize - 1;

                let distance = dist[u_query][v_query];
                if distance == infinity {
                    results.push(-1);
                } else {
                    results.push(distance);
                }
            }
        }

        results
    }
}