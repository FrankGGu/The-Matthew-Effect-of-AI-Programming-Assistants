struct Solution;

impl Solution {
    pub fn find_the_city(n: i32, edges: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let n_usize = n as usize;
        let infinity = i32::MAX / 2;

        let mut dist: Vec<Vec<i32>> = vec![vec![infinity; n_usize]; n_usize];

        for i in 0..n_usize {
            dist[i][i] = 0;
        }

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            dist[u][v] = w;
            dist[v][u] = w;
        }

        for k in 0..n_usize {
            for i in 0..n_usize {
                for j in 0..n_usize {
                    if dist[i][k] != infinity && dist[k][j] != infinity {
                        dist[i][j] = dist[i][j].min(dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        let mut min_reachable_cities = n_usize + 1;
        let mut result_city = -1;

        for i in 0..n_usize {
            let mut current_reachable_cities_count = 0;
            for j in 0..n_usize {
                if i == j {
                    continue;
                }
                if dist[i][j] <= threshold {
                    current_reachable_cities_count += 1;
                }
            }

            if current_reachable_cities_count <= min_reachable_cities {
                min_reachable_cities = current_reachable_cities_count;
                result_city = i as i32;
            }
        }

        result_city
    }
}