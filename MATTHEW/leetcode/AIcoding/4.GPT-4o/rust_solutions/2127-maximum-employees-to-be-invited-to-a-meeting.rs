impl Solution {
    pub fn max_invitations(friends: Vec<Vec<i32>>) -> i32 {
        let n = friends.len();
        let mut graph = vec![Vec::new(); n];
        for (i, f) in friends.iter().enumerate() {
            for &friend in f {
                graph[i].push(friend as usize);
            }
        }

        let mut max_invite = 0;

        fn dfs(node: usize, graph: &Vec<Vec<usize>>, visited: &mut Vec<bool>, count: &mut i32) {
            visited[node] = true;
            *count += 1;
            for &neighbor in &graph[node] {
                if !visited[neighbor] {
                    dfs(neighbor, graph, visited, count);
                }
            }
        }

        for i in 0..n {
            let mut visited = vec![false; n];
            let mut count = 0;
            dfs(i, &graph, &mut visited, &mut count);
            max_invite = max_invite.max(count);
        }

        max_invite
    }
}