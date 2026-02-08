use std::collections::{HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn check_if_prerequisite(n: i32, prerequisites: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut graph = vec![vec![]; n as usize];
        let mut indegree = vec![0; n as usize];

        for pre in &prerequisites {
            graph[pre[0] as usize].push(pre[1]);
            indegree[pre[1] as usize] += 1;
        }

        let mut reachable = vec![vec![false; n as usize]; n as usize];

        for i in 0..n {
            reachable[i as usize][i as usize] = true;
        }

        let mut queue = vec![];

        for i in 0..n {
            if indegree[i as usize] == 0 {
                queue.push(i);
            }
        }

        while !queue.is_empty() {
            let course = queue.remove(0);
            for &next in &graph[course as usize] {
                reachable[course as usize][next as usize] = true;
                for j in 0..n {
                    if reachable[course as usize][j as usize] {
                        reachable[next as usize][j as usize] = true;
                    }
                }
                indegree[next as usize] -= 1;
                if indegree[next as usize] == 0 {
                    queue.push(next);
                }
            }
        }

        queries.iter()
            .map(|query| reachable[query[0] as usize][query[1] as usize])
            .collect()
    }
}