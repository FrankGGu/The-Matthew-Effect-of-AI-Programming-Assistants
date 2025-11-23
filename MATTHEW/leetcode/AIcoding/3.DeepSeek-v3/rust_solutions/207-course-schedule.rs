use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
        let num_courses = num_courses as usize;
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut in_degree = vec![0; num_courses];

        for edge in prerequisites {
            let u = edge[1];
            let v = edge[0];
            graph.entry(u).or_default().push(v);
            in_degree[v as usize] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i as i32);
            }
        }

        let mut count = 0;
        while let Some(u) = queue.pop_front() {
            count += 1;
            if let Some(neighbors) = graph.get(&u) {
                for &v in neighbors {
                    in_degree[v as usize] -= 1;
                    if in_degree[v as usize] == 0 {
                        queue.push_back(v);
                    }
                }
            }
        }

        count == num_courses
    }
}