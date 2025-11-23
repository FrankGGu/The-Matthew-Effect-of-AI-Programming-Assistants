use std::collections::{VecDeque, HashMap};

pub fn min_number_of_semesters(n: i32, relations: Vec<Vec<i32>>, k: i32) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    let mut indegree = vec![0; n as usize];

    for relation in relations {
        let a = relation[0] - 1;
        let b = relation[1] - 1;
        graph[a as usize].push(b as usize);
        indegree[b as usize] += 1;
    }

    let mut dp = vec![std::i32::MAX; n as usize];
    dp[0] = 0;
    let mut queue = VecDeque::new();
    queue.push_back(0);

    while let Some(node) = queue.pop_front() {
        let mut count = 0;
        let mut next_nodes = vec![];
        for &neighbor in &graph[node] {
            indegree[neighbor] -= 1;
            if indegree[neighbor] == 0 {
                next_nodes.push(neighbor);
                count += 1;
            }
        }

        for i in (0..next_nodes.len()).step_by(k as usize) {
            let end = std::cmp::min(i + k as usize, next_nodes.len());
            for j in i..end {
                dp[next_nodes[j]] = dp[next_nodes[j]].min(dp[node] + 1);
            }
            if end == next_nodes.len() {
                break;
            }
        }

        for &next in next_nodes.iter() {
            queue.push_back(next);
        }
    }

    *dp.iter().max().unwrap() + 1
}