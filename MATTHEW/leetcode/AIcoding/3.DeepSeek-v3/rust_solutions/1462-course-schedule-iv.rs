impl Solution {
    pub fn check_if_prerequisite(num_courses: i32, prerequisites: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let num_courses = num_courses as usize;
        let mut graph = vec![vec![false; num_courses]; num_courses];

        for edge in prerequisites {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u][v] = true;
        }

        for k in 0..num_courses {
            for i in 0..num_courses {
                for j in 0..num_courses {
                    if graph[i][k] && graph[k][j] {
                        graph[i][j] = true;
                    }
                }
            }
        }

        queries.into_iter().map(|q| {
            let u = q[0] as usize;
            let v = q[1] as usize;
            graph[u][v]
        }).collect()
    }
}