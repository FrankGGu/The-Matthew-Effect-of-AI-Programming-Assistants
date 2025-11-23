pub fn maximize_score(nums: Vec<i32>, edges: Vec<Vec<i32>>, score: Vec<i32>) -> i32 {
    use itertools::Itertools;

    let n = nums.len();
    let mut graph = vec![vec![]; n];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1] as usize);
        graph[edge[1] as usize].push(edge[0] as usize);
    }

    let mut max_score = 0;
    let mut visited = vec![false; n];

    fn dfs(node: usize, graph: &Vec<Vec<usize>>, visited: &mut Vec<bool>, score: &Vec<i32>, current_score: &mut i32) {
        visited[node] = true;
        *current_score += score[node];

        for &neighbor in &graph[node] {
            if !visited[neighbor] {
                dfs(neighbor, graph, visited, score, current_score);
            }
        }
    }

    for combo in (0..n).combinations(2) {
        let mut current_score = 0;
        let mut local_visited = visited.clone();

        for &node in &combo {
            if !local_visited[node] {
                dfs(node, &graph, &mut local_visited, &score, &mut current_score);
            }
        }

        max_score = max_score.max(current_score);
    }

    max_score
}