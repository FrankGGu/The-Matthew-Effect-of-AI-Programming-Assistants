pub fn sequence_reconstruction(org: Vec<i32>, seqs: Vec<Vec<i32>>) -> bool {
    use std::collections::{HashMap, HashSet};

    let n = org.len();
    let mut graph = vec![HashSet::new(); n + 1];
    let mut in_degree = vec![0; n + 1];

    for seq in seqs {
        for i in 0..seq.len() {
            if seq[i] < 1 || seq[i] > n {
                return false;
            }
            if i > 0 {
                if !graph[seq[i - 1] as usize].contains(&seq[i]) {
                    graph[seq[i - 1] as usize].insert(seq[i]);
                    in_degree[seq[i] as usize] += 1;
                }
            }
        }
    }

    let mut queue = std::collections::VecDeque::new();
    for i in 1..=n {
        if in_degree[i] == 0 {
            queue.push_back(i);
        }
    }

    let mut reconstructed = Vec::new();
    while let Some(node) = queue.pop_front() {
        reconstructed.push(node);
        if reconstructed.len() > org.len() {
            return false;
        }
        let mut count = 0;
        for &neighbor in &graph[node] {
            in_degree[neighbor as usize] -= 1;
            if in_degree[neighbor as usize] == 0 {
                queue.push_back(neighbor);
                count += 1;
            }
        }
        if count > 1 {
            return false;
        }
    }

    reconstructed == org
}