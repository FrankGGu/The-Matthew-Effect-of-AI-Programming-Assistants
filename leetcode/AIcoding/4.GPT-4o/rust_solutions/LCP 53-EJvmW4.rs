pub fn can_guard_space_city(cities: Vec<Vec<i32>>) -> bool {
    let n = cities.len();
    let mut graph = vec![vec![]; n];

    for i in 0..n {
        for j in i + 1..n {
            if (cities[i][0] - cities[j][0]).abs() + (cities[i][1] - cities[j][1]).abs() <= 2 {
                graph[i].push(j);
                graph[j].push(i);
            }
        }
    }

    let mut visited = vec![false; n];
    let mut stack = vec![0];

    while let Some(node) = stack.pop() {
        if visited[node] {
            continue;
        }
        visited[node] = true;
        for &neighbor in &graph[node] {
            if !visited[neighbor] {
                stack.push(neighbor);
            }
        }
    }

    visited.iter().all(|&x| x)
}