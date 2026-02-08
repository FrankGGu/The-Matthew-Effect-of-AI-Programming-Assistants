pub fn minimum_cost(transport: Vec<Vec<i32>>, n: i32) -> i32 {
    let mut min_cost = vec![i32::MAX; n as usize];
    min_cost[0] = 0;
    let mut visited = vec![false; n as usize];

    for _ in 0..n {
        let mut u = -1;
        for i in 0..n {
            if !visited[i as usize] && (u == -1 || min_cost[i as usize] < min_cost[u as usize]) {
                u = i;
            }
        }

        visited[u as usize] = true;

        for v in 0..n {
            if !visited[v as usize] && transport[u as usize][v as usize] > 0 {
                min_cost[v as usize] = min_cost[v as usize].min(min_cost[u as usize] + transport[u as usize][v as usize]);
            }
        }
    }

    min_cost[n as usize - 1].max(0)
}