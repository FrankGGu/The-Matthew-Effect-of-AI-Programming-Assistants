impl Solution {
    pub fn maximum_points(edges: Vec<Vec<i32>>, tourists: i32, locations: Vec<i32>) -> i64 {
        let n = locations.len();
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let mut max_points: i64 = 0;

        fn dfs(
            curr: usize,
            visited: &mut Vec<bool>,
            curr_points: i64,
            tourists_left: i32,
            adj: &Vec<Vec<i32>>,
            locations: &Vec<i32>,
            max_points: &mut i64,
            n: usize
        ) {
            if tourists_left < 0 {
                return;
            }

            visited[curr] = true;
            let new_points = curr_points + locations[curr] as i64;
            *max_points = (*max_points).max(new_points);

            for &neighbor in &adj[curr] {
                let next = neighbor as usize;
                if !visited[next] {
                    let dist = (locations[curr] - locations[next]).abs();
                    dfs(
                        next,
                        &mut visited.clone(),
                        new_points,
                        tourists_left - dist,
                        adj,
                        locations,
                        max_points,
                        n
                    );
                }
            }
        }

        for start_node in 0..n {
            let mut visited: Vec<bool> = vec![false; n];
            dfs(
                start_node,
                &mut visited,
                0,
                tourists,
                &adj,
                &locations,
                &mut max_points,
                n
            );
        }

        max_points
    }
}