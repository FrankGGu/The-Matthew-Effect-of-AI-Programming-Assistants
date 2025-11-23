impl Solution {
    pub fn volunteer_deployment(final_cnt: Vec<i64>, edges: Vec<Vec<i32>>, mut plans: Vec<Vec<i32>>, seed: i64) -> Vec<i64> {
        let n = final_cnt.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u - 1].push(v - 1);
            adj[v - 1].push(u - 1);
        }

        let mut in_degree: Vec<usize> = vec![0; n];
        for i in 0..n {
            in_degree[i] = adj[i].len();
        }

        let mut a: Vec<i64> = vec![0; n];
        let mut b: Vec<i64> = vec![0; n];

        for i in 0..n {
            a[i] = 1;
            b[i] = 0;
        }

        for plan in &plans {
            let op = plan[0];
            let idx = plan[1] as usize - 1;
            let val = plan[2] as i64;

            match op {
                1 => {
                    a[idx] -= 1;
                    for &neighbor in &adj[idx] {
                        b[neighbor] += val;
                    }
                }
                2 => {
                    a[idx] += 1;
                    for &neighbor in &adj[idx] {
                        b[neighbor] -= val;
                    }
                }
                3 => {
                    for &neighbor in &adj[idx] {
                        a[neighbor] += 1;
                        b[idx] -= val;
                    }
                    a[idx] -= in_degree[idx] as i64;
                }
                _ => {}
            }
        }

        let mut sum_b: i64 = 0;
        for i in 0..n {
            sum_b += b[i];
        }

        let mut sum_a: i64 = 0;
        for i in 0..n {
            sum_a += a[i];
        }

        let mut sum_final_cnt: i64 = 0;
        for i in 0..n {
            sum_final_cnt += final_cnt[i];
        }

        let x = (sum_final_cnt - sum_b) / sum_a;

        let mut ans: Vec<i64> = vec![0; n];
        for i in 0..n {
            ans[i] = a[i] * x + b[i];
        }

        ans
    }
}