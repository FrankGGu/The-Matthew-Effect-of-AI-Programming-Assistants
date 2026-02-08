use std::collections::HashSet;

pub fn magnificent_sets(n: i32, edges: Vec<Vec<i32>>) -> i32 {
    let mut graph = vec![Vec::new(); n as usize + 1];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut visited = vec![false; n as usize + 1];
    let mut max_groups = 0;

    fn dfs(node: i32, color: i32, graph: &Vec<Vec<i32>>, visited: &mut Vec<i32>, colors: &mut Vec<i32>) -> bool {
        visited[node as usize] = true;
        colors[node as usize] = color;

        for &neighbor in &graph[node as usize] {
            if !visited[neighbor as usize] {
                if !dfs(neighbor, 1 - color, graph, visited, colors) {
                    return false;
                }
            } else if colors[neighbor as usize] == color {
                return false;
            }
        }
        true
    }

    for i in 1..=n {
        if !visited[i as usize] {
            let mut colors = vec![-1; n as usize + 1];
            if dfs(i, 0, &graph, &mut visited, &mut colors) {
                max_groups += 1;
            }
        }
    }

    max_groups
}