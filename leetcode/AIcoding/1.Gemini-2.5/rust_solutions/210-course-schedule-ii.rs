use std::collections::VecDeque;

impl Solution {
    pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
        let n = num_courses as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut in_degree: Vec<i32> = vec![0; n];

        for prereq in prerequisites {
            let course = prereq[0] as usize;
            let prerequisite = prereq[1] as usize;
            adj[prerequisite].push(course);
            in_degree[course] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result: Vec<i32> = Vec::new();
        while let Some(u) = queue.pop_front() {
            result.push(u as i32);
            for &v in &adj[u] {
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        if result.len() == n {
            result
        } else {
            vec![]
        }
    }
}