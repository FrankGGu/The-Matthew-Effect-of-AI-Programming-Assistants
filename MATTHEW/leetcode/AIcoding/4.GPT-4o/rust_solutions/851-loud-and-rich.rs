use std::collections::{HashMap, HashSet};

pub fn loud_and_rich(richer: Vec<Vec<i32>>, quiet: Vec<i32>) -> Vec<i32> {
    let n = quiet.len();
    let mut graph: Vec<HashSet<i32>> = vec![HashSet::new(); n];
    let mut indegree = vec![0; n];

    for r in richer {
        graph[r[1] as usize].insert(r[0]);
        indegree[r[0] as usize] += 1;
    }

    let mut queue: Vec<i32> = (0..n).filter(|&i| indegree[i as usize] == 0).collect();
    let mut answer = quiet.clone();

    while let Some(node) = queue.pop() {
        for &neighbor in &graph[node as usize] {
            if answer[node as usize] < answer[neighbor as usize] {
                answer[neighbor as usize] = answer[node as usize];
            }
            indegree[neighbor as usize] -= 1;
            if indegree[neighbor as usize] == 0 {
                queue.push(neighbor);
            }
        }
    }

    answer
}