impl Solution {
    pub fn dominoes(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = vec![false; n as usize];
        let mut components = 0;

        for i in 0..n {
            if !visited[i as usize] {
                components += 1;
                let mut stack = vec![i];
                while let Some(node) = stack.pop() {
                    if !visited[node as usize] {
                        visited[node as usize] = true;
                        for &neighbour in &graph[node as usize] {
                            stack.push(neighbour);
                        }
                    }
                }
            }
        }

        components - 1
    }
}