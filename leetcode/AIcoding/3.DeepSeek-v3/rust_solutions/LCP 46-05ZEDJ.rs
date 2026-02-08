impl Solution {
    pub fn volunteer_deployment(final_status: Vec<i32>, total_volunteers: i64, edges: Vec<Vec<i32>>, plans: Vec<Vec<i32>>) -> Vec<i64> {
        let n = final_status.len();
        let mut a = vec![0; n];
        let mut b = vec![0; n];
        for i in 0..n {
            b[i] = final_status[i] as i64;
        }
        a[0] = 1;

        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        for plan in plans.iter().rev() {
            let num = plan[0];
            let idx = plan[1] as usize;
            match num {
                1 => {
                    a[idx] *= 2;
                    b[idx] *= 2;
                },
                2 => {
                    for &nei in &adj[idx] {
                        a[nei] -= a[idx];
                        b[nei] -= b[idx];
                    }
                },
                3 => {
                    for &nei in &adj[idx] {
                        a[nei] += a[idx];
                        b[nei] += b[idx];
                    }
                },
                _ => (),
            }
        }

        let mut sum_a = 0;
        let mut sum_b = 0;
        for i in 0..n {
            sum_a += a[i];
            sum_b += b[i];
        }

        let x = if sum_a != 0 {
            (total_volunteers - sum_b) / sum_a
        } else {
            0
        };

        let mut res = vec![0; n];
        for i in 0..n {
            res[i] = a[i] * x + b[i];
        }

        res
    }
}