use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
        let num_courses = num_courses as usize;
        let mut adj: HashMap<usize, Vec<usize>> = HashMap::new();
        let mut in_degree: Vec<i32> = vec![0; num_courses];

        for pre in &prerequisites {
            let course = pre[0] as usize;
            let prerequisite = pre[1] as usize;
            adj.entry(prerequisite).or_insert(Vec::new()).push(course);
            in_degree[course] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..num_courses {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut result: Vec<i32> = Vec::new();
        let mut count = 0;

        while let Some(course) = queue.pop_front() {
            result.push(course as i32);
            count += 1;

            if let Some(neighbors) = adj.get(&course) {
                for &neighbor in neighbors {
                    in_degree[neighbor] -= 1;
                    if in_degree[neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        if count == num_courses {
            result
        } else {
            Vec::new()
        }
    }
}