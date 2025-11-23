pub fn maximal_network_rank(n: i32, roads: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut graph = vec![HashSet::new(); n as usize];
    for road in roads.iter() {
        graph[road[0] as usize].insert(road[1]);
        graph[road[1] as usize].insert(road[0]);
    }

    let mut max_rank = 0;
    for i in 0..n {
        for j in i + 1..n {
            let mut rank = graph[i as usize].len() + graph[j as usize].len();
            if graph[i as usize].contains(&j) {
                rank -= 1;
            }
            max_rank = max_rank.max(rank);
        }
    }

    max_rank
}