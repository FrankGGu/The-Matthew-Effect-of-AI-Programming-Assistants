use std::collections::{HashMap, HashSet};

pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut indegree = vec![0; num_courses as usize];

    for prereq in prerequisites.iter() {
        let next = prereq[0];
        let prev = prereq[1];
        graph.entry(prev).or_insert(vec![]).push(next);
        indegree[next as usize] += 1;
    }

    let mut queue = std::collections::VecDeque::new();
    for i in 0..num_courses {
        if indegree[i as usize] == 0 {
            queue.push_back(i);
        }
    }

    let mut count = 0;
    while let Some(course) = queue.pop_front() {
        count += 1;
        if let Some(neighbors) = graph.get(&course) {
            for &neighbor in neighbors {
                indegree[neighbor as usize] -= 1;
                if indegree[neighbor as usize] == 0 {
                    queue.push_back(neighbor);
                }
            }
        }
    }

    count == num_courses
}