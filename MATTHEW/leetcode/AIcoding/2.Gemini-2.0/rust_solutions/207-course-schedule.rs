use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
        let num_courses = num_courses as usize;
        let mut adj: HashMap<usize, Vec<usize>> = HashMap::new();
        let mut in_degree: Vec<i32> = vec![0; num_courses];

        for prerequisite in &prerequisites {
            let course = prerequisite[0] as usize;
            let pre_req = prerequisite[1] as usize;
            adj.entry(pre_req).or_insert(Vec::new()).push(course);
            in_degree[course] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut count = 0;
        while let Some(node) = queue.pop_front() {
            count += 1;
            if let Some(neighbors) = adj.get(&node) {
                for &neighbor in neighbors {
                    in_degree[neighbor] -= 1;
                    if in_degree[neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        count == num_courses
    }
}