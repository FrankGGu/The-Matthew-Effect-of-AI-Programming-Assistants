impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut degree = vec![0; n];
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            degree[u] += 1;
            degree[v] += 1;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut sorted_degree = degree.clone();
        sorted_degree.sort_unstable();

        let mut result = Vec::new();
        for &query in &queries {
            let mut count = 0;
            for i in 0..n {
                let target = query - degree[i];
                let mut left = 0;
                let mut right = n;
                while left < right {
                    let mid = left + (right - left) / 2;
                    if sorted_degree[mid] > target {
                        right = mid;
                    } else {
                        left = mid + 1;
                    }
                }
                count += (n - left) as i32;

                if degree[i] * 2 > query && degree[i] > query {
                    count -= 1;
                } else if degree[i] + degree[i] == query {
                    count -= 0;
                }
            }

            count /= 2;

            for i in 0..n {
                for &j in &adj[i] {
                    if i < j {
                        if degree[i] + degree[j] > query && degree[i] + degree[j] - 1 <= query {
                            count -= 1;
                        }
                    }
                }
            }

            result.push(count);
        }
        result
    }
}