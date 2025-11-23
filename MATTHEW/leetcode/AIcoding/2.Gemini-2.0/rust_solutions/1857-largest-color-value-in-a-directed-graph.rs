use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn largest_color_value(colors: String, edges: Vec<Vec<i32>>) -> i32 {
        let n = colors.len();
        let colors: Vec<char> = colors.chars().collect();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        let mut indegree: Vec<i32> = vec![0; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            indegree[v] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..n {
            if indegree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut count: Vec<Vec<i32>> = vec![vec![0; 26]; n];
        for i in 0..n {
            count[i][(colors[i] as u8 - b'a') as usize] = 1;
        }

        let mut visited = 0;
        let mut ans = 0;

        while !queue.is_empty() {
            let u = queue.pop_front().unwrap();
            visited += 1;
            ans = ans.max(count[u].iter().max().unwrap().clone());

            for &v in &adj[u] {
                for i in 0..26 {
                    count[v][i] = count[v][i].max(count[u][i] + if (colors[v] as u8 - b'a') as usize == i { 1 } else { 0 });
                }
                indegree[v] -= 1;
                if indegree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        if visited == n {
            ans
        } else {
            -1
        }
    }
}