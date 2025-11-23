use std::collections::VecDeque;

pub fn collect_coins(coins: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
    let n = coins.len();
    let mut graph = vec![vec![]; n];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut has_coin = vec![false; n];
    for i in 0..n {
        if coins[i] > 0 {
            has_coin[i] = true;
        }
    }

    let mut visited = vec![false; n];
    let mut queue = VecDeque::new();

    for i in 0..n {
        if has_coin[i] {
            queue.push_back(i);
        }
    }

    while let Some(node) = queue.pop_front() {
        visited[node] = true;
        for &neigh in &graph[node] {
            if !visited[neigh] {
                visited[neigh] = true;
                if has_coin[neigh] {
                    queue.push_back(neigh);
                }
            }
        }
    }

    let mut total_distance = 0;
    let mut count = 0;

    for i in 0..n {
        if visited[i] {
            count += 1;
            for &neigh in &graph[i] {
                if visited[neigh] {
                    total_distance += 1;
                }
            }
        }
    }

    if count > 0 {
        total_distance -= count - 1;
    }

    total_distance
}