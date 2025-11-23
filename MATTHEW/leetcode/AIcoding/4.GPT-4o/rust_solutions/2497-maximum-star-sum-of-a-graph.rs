impl Solution {
    pub fn max_star_sum(vals: Vec<i32>, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = vals.len();
        let mut graph = vec![Vec::new(); n];

        for edge in edges {
            graph[edge[0] as usize].push(vals[edge[1] as usize]);
            graph[edge[1] as usize].push(vals[edge[0] as usize]);
        }

        let mut result = 0;

        for i in 0..n {
            let mut star_sum = vals[i];
            let mut edge_vals = graph[i].clone();
            edge_vals.sort_unstable_by(|a, b| b.cmp(a));
            for &val in edge_vals.iter().take(k as usize) {
                if val > 0 {
                    star_sum += val;
                }
            }
            result = result.max(star_sum);
        }

        result
    }
}