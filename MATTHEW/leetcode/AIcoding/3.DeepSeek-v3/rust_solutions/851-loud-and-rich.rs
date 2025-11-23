impl Solution {
    pub fn loud_and_rich(richer: Vec<Vec<i32>>, quiet: Vec<i32>) -> Vec<i32> {
        let n = quiet.len();
        let mut graph = vec![vec![]; n];
        for edge in richer {
            let u = edge[1] as usize;
            let v = edge[0] as usize;
            graph[u].push(v);
        }

        let mut answer = vec![-1; n];
        for i in 0..n {
            if answer[i] == -1 {
                Self::dfs(i, &graph, &quiet, &mut answer);
            }
        }
        answer
    }

    fn dfs(node: usize, graph: &Vec<Vec<usize>>, quiet: &Vec<i32>, answer: &mut Vec<i32>) -> i32 {
        if answer[node] != -1 {
            return answer[node];
        }
        let mut min_quiet = node as i32;
        for &neighbor in &graph[node] {
            let candidate = Self::dfs(neighbor, graph, quiet, answer);
            if quiet[candidate as usize] < quiet[min_quiet as usize] {
                min_quiet = candidate;
            }
        }
        answer[node] = min_quiet;
        min_quiet
    }
}