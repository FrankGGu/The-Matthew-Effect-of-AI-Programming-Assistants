impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn course_schedule_iv(num_courses: i32, prerequisites: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let num = num_courses as usize;
        let mut graph = vec![vec![]; num];
        let mut in_degree = vec![0; num];

        for pre in &prerequisites {
            let u = pre[1] as usize;
            let v = pre[0] as usize;
            graph[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..num {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut order = vec![];
        while let Some(u) = queue.pop_front() {
            order.push(u);
            for &v in &graph[u] {
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        let mut pos = vec![0; num];
        for (i, &course) in order.iter().enumerate() {
            pos[course] = i;
        }

        let mut result = vec![];
        for query in &queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            result.push(pos[u] < pos[v]);
        }

        result
    }
}
}