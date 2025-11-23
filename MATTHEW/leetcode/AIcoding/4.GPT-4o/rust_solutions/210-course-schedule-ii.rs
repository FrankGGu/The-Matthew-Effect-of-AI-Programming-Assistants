use std::collections::{HashMap, HashSet, VecDeque};

pub fn find_order(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> Vec<i32> {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut indegree = vec![0; num_courses as usize];

    for pre in prerequisites {
        let a = pre[0];
        let b = pre[1];
        graph.entry(b).or_insert_with(Vec::new).push(a);
        indegree[a as usize] += 1;
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
            for &next in neighbors {
                indegree[next as usize] -= 1;
                if indegree[next as usize] == 0 {
                    queue.push_back(next);
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