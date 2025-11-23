impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_all_people(n: i32, meetings: Vec<Vec<i32>>, first_person: i32) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for meeting in meetings {
            let u = meeting[0] as usize;
            let v = meeting[1] as usize;
            let time = meeting[2];
            graph[u].push((v, time));
            graph[v].push((u, time));
        }

        let mut visited = HashSet::new();
        visited.insert(first_person);
        let mut queue = VecDeque::new();
        queue.push_back(first_person);

        while let Some(person) = queue.pop_front() {
            for &(neighbor, time) in &graph[person as usize] {
                if !visited.contains(&neighbor) && time >= 0 {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        visited.into_iter().collect()
    }
}
}