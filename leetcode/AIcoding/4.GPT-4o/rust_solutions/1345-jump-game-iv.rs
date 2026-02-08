use std::collections::VecDeque;

pub fn min_jumps(arr: Vec<i32>) -> i32 {
    let n = arr.len();
    if n <= 1 {
        return 0;
    }

    let mut graph = std::collections::HashMap::new();
    for (i, &value) in arr.iter().enumerate() {
        graph.entry(value).or_insert(vec![]).push(i);
    }

    let mut queue = VecDeque::new();
    queue.push_back(0);
    let mut visited = vec![false; n];
    visited[0] = true;
    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let index = queue.pop_front().unwrap();
            if index == n - 1 {
                return steps;
            }
            let value = arr[index];
            let neighbors = graph.get(&value).unwrap_or(&vec![]);
            for &neighbor in neighbors {
                if !visited[neighbor] {
                    visited[neighbor] = true;
                    queue.push_back(neighbor);
                }
            }
            graph.remove(&value);
            if index > 0 && !visited[index - 1] {
                visited[index - 1] = true;
                queue.push_back(index - 1);
            }
            if index < n - 1 && !visited[index + 1] {
                visited[index + 1] = true;
                queue.push_back(index + 1);
            }
        }
        steps += 1;
    }

    -1
}