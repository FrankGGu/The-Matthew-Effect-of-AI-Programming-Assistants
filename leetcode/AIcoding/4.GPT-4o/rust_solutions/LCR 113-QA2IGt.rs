use std::collections::{HashMap, HashSet, VecDeque};

pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut indegree = vec![0; num_courses as usize];

    for pre in prerequisites {
        let (course, prereq) = (pre[0], pre[1]);
        graph.entry(prereq).or_insert(vec![]).push(course);
        indegree[course as usize] += 1;
    }

    let mut queue = VecDeque::new();
    for i in 0..num_courses {
        if indegree[i as usize] == 0 {
            queue.push_back(i);
        }
    }

    let mut order = Vec::new();
    while let Some(course) = queue.pop_front() {
        order.push(course);
        if let Some(neighbors) = graph.get(&course) {
            for &neighbor in neighbors {
                indegree[neighbor as usize] -= 1;
                if indegree[neighbor as usize] == 0 {
                    queue.push_back(neighbor);
                }
            }
        }
    }

    if order.len() == num_courses as usize {
        order
    } else {
        vec![]
    }
}