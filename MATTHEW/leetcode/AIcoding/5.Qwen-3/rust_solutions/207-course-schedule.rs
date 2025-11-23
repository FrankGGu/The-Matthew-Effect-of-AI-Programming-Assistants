impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
        let mut graph = vec![vec![]; num_courses as usize];
        let mut in_degree = vec![0; num_courses as usize];

        for pre in prerequisites {
            let course = pre[0];
            let prerequisite = pre[1];
            graph[prerequisite as usize].push(course);
            in_degree[course as usize] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i as usize] == 0 {
                queue.push_back(i);
            }
        }

        let mut count = 0;
        while let Some(course) = queue.pop_front() {
            count += 1;
            for &next_course in &graph[course as usize] {
                in_degree[next_course as usize] -= 1;
                if in_degree[next_course as usize] == 0 {
                    queue.push_back(next_course);
                }
            }
        }

        count == num_courses
    }
}
}