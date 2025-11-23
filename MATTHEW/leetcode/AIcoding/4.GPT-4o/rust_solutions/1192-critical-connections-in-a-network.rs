use std::collections::{HashMap, HashSet};

pub fn critical_connections(n: i32, connections: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut graph = vec![vec![]; n as usize];
    for conn in &connections {
        graph[conn[0] as usize].push(conn[1]);
        graph[conn[1] as usize].push(conn[0]);
    }

    let mut disc = vec![-1; n as usize];
    let mut low = vec![-1; n as usize];
    let mut result = vec![];
    let mut time = 0;

    fn dfs(
        u: usize,
        parent: i32,
        time: &mut i32,
        disc: &mut Vec<i32>,
        low: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
        graph: &Vec<Vec<i32>>,
    ) {
        disc[u] = *time;
        low[u] = *time;
        *time += 1;

        for &v in &graph[u] {
            if disc[v as usize] == -1 {
                dfs(v as usize, u as i32, time, disc, low, result, graph);
                low[u] = low[u].min(low[v as usize]);
                if low[v as usize] > disc[u] {
                    result.push(vec![u as i32, v]);
                }
            } else if v as i32 != parent {
                low[u] = low[u].min(disc[v as usize]);
            }
        }
    }

    for i in 0..n {
        if disc[i as usize] == -1 {
            dfs(i as usize, -1, &mut time, &mut disc, &mut low, &mut result, &graph);
        }
    }

    result
}