pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    for (i, &m) in manager.iter().enumerate() {
        if m != -1 {
            graph[m as usize].push(i as i32);
        }
    }

    fn dfs(node: i32, inform_time: &Vec<i32>, graph: &Vec<Vec<i32>>) -> i32 {
        let mut max_time = 0;
        for &sub in &graph[node as usize] {
            max_time = max_time.max(dfs(sub, inform_time, graph));
        }
        max_time + inform_time[node as usize]
    }

    dfs(head_id, &inform_time, &graph)
}