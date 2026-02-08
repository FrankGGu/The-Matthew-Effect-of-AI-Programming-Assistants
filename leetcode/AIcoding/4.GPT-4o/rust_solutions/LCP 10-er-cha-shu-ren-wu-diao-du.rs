use std::collections::HashMap;

pub fn minimum_time(n: i32, dependencies: Vec<Vec<i32>>) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    let mut indegree = vec![0; n as usize];
    let mut time = vec![0; n as usize];

    for dep in dependencies {
        let (a, b) = (dep[0] as usize, dep[1] as usize);
        graph[b].push(a);
        indegree[a] += 1;
    }

    let mut queue = std::collections::VecDeque::new();
    for i in 0..n {
        if indegree[i as usize] == 0 {
            queue.push_back(i as usize);
        }
    }

    let mut total_time = 0;
    while let Some(node) = queue.pop_front() {
        total_time = total_time.max(time[node]);
        for &next in &graph[node] {
            time[next] = time[next].max(time[node] + 1);
            indegree[next] -= 1;
            if indegree[next] == 0 {
                queue.push_back(next);
            }
        }
    }

    total_time + 1
}