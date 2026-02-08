use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn collect_the_coins(coins: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = coins.len();
        let mut graph = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].insert(v);
            graph[v].insert(u);
        }

        let mut q = VecDeque::new();
        for i in 0..n {
            if graph[i].len() == 1 && coins[i] == 0 {
                q.push_back(i);
            }
        }

        while let Some(u) = q.pop_front() {
            if graph[u].is_empty() {
                continue;
            }
            let v = *graph[u].iter().next().unwrap();
            graph[u].remove(&v);
            graph[v].remove(&u);
            if graph[v].len() == 1 && coins[v] == 0 {
                q.push_back(v);
            }
        }

        for _ in 0..2 {
            let mut q = VecDeque::new();
            for i in 0..n {
                if graph[i].len() == 1 {
                    q.push_back(i);
                }
            }
            if q.is_empty() {
                break;
            }
            while let Some(u) = q.pop_front() {
                if graph[u].is_empty() {
                    continue;
                }
                let v = *graph[u].iter().next().unwrap();
                graph[u].remove(&v);
                graph[v].remove(&u);
            }
        }

        let mut count = 0;
        for i in 0..n {
            if !graph[i].is_empty() {
                count += 1;
            }
        }

        if count == 0 {
            0
        } else {
            ((count - 1) * 2) as i32
        }
    }
}