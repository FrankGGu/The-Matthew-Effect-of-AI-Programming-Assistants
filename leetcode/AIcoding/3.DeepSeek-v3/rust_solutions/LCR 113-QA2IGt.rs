impl Solution {
    pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
        let num_courses = num_courses as usize;
        let mut graph = vec![vec![]; num_courses];
        let mut in_degree = vec![0; num_courses];

        for edge in prerequisites {
            let u = edge[1] as usize;
            let v = edge[0] as usize;
            graph[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = std::collections::VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result = Vec::new();
        while let Some(u) = queue.pop_front() {
            result.push(u as i32);
            for &v in &graph[u] {
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        if result.len() == num_courses {
            result
        } else {
            vec![]
        }
    }
}