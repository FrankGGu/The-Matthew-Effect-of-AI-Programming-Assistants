impl Solution {
    pub fn count_infection_sequences(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = vec![false; n as usize];
        let mut count = 0;

        fn dfs(node: usize, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, sequence: &mut Vec<i32>) {
            visited[node] = true;
            sequence.push(node as i32);
            for &neighbor in &graph[node] {
                if !visited[neighbor as usize] {
                    dfs(neighbor as usize, graph, visited, sequence);
                }
            }
        }

        for i in 0..n as usize {
            if !visited[i] {
                let mut sequence = vec![];
                dfs(i, &graph, &mut visited, &mut sequence);
                count += 1;
            }
        }

        count
    }
}