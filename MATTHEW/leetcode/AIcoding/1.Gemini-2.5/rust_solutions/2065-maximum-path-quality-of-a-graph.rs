struct Solution;

impl Solution {
    fn dfs(
        u: usize,
        current_time: i32,
        current_quality: i64,
        visited_counts: &mut Vec<i32>,
        adj: &Vec<Vec<(usize, i32)>>,
        values: &Vec<i32>,
        max_time: i32,
        max_quality: &mut i64,
    ) {
        *max_quality = (*max_quality).max(current_quality);

        for &(v, weight) in adj[u].iter() {
            if current_time + weight <= max_time {
                let mut new_quality = current_quality;
                let is_first_visit = visited_counts[v] == 0;

                visited_counts[v] += 1;
                if is_first_visit {
                    new_quality += values[v] as i64;
                }

                Self::dfs(
                    v,
                    current_time + weight,
                    new_quality,
                    visited_counts,
                    adj,
                    values,
                    max_time,
                    max_quality,
                );

                visited_counts[v] -= 1;
            }
        }
    }

    pub fn max_path_quality(
        values: Vec<i32>,
        edges: Vec<Vec<i32>>,
        max_time: i32,
    ) -> i32 {
        let n = values.len();
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let t = edge[2];
            adj[u].push((v, t));
            adj[v].push((u, t));
        }

        let mut visited_counts: Vec<i32> = vec![0; n];
        let mut max_quality: i64 = 0;

        visited_counts[0] = 1;
        Self::dfs(
            0,
            0,
            values[0] as i64,
            &mut visited_counts,
            &adj,
            &values,
            max_time,
            &mut max_quality,
        );

        max_quality as i32
    }
}