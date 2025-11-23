use std::collections::{HashMap, VecDeque};

pub fn minimum_time(n: i32, relations: Vec<Vec<i32>>, time: Vec<i32>) -> i32 {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut in_degree: Vec<i32> = vec![0; n as usize + 1];
    let mut dp: Vec<i32> = vec![0; n as usize + 1];

    for rel in relations {
        let (a, b) = (rel[0], rel[1]);
        graph.entry(a).or_insert(vec![]).push(b);
        in_degree[b as usize] += 1;
    }

    let mut queue: VecDeque<i32> = VecDeque::new();

    for i in 1..=n {
        if in_degree[i as usize] == 0 {
            queue.push_back(i);
            dp[i as usize] = time[i as usize - 1];
        }
    }

    while let Some(node) = queue.pop_front() {
        for &neighbor in graph.get(&node).unwrap_or(&vec![]) {
            in_degree[neighbor as usize] -= 1;
            dp[neighbor as usize] = dp[neighbor as usize].max(dp[node as usize] + time[neighbor as usize - 1]);
            if in_degree[neighbor as usize] == 0 {
                queue.push_back(neighbor);
            }
        }
    }

    dp.iter().copied().max().unwrap_or(0)
}