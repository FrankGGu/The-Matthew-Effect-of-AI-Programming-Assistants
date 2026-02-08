use std::collections::{HashMap, HashSet, VecDeque};

pub struct Solution;

impl Solution {
    pub fn shortest_path(m: Vec<Vec<i32>>, start: Vec<i32>, end: Vec<i32>) -> i32 {
        let mut graph: HashMap<(i32, i32), Vec<((i32, i32), i32)>> = HashMap::new();
        let rows = m.len() as i32;
        let cols = m[0].len() as i32;

        for i in 0..rows {
            for j in 0..cols {
                let current = (i, j);
                if i > 0 {
                    let neighbor = (i - 1, j);
                    graph.entry(current).or_insert_with(Vec::new).push((neighbor, m[i as usize][j as usize] + m[(i-1) as usize][j as usize]));
                    graph.entry(neighbor).or_insert_with(Vec::new).push((current, m[i as usize][j as usize] + m[(i-1) as usize][j as usize]));
                }
                if j > 0 {
                    let neighbor = (i, j - 1);
                    graph.entry(current).or_insert_with(Vec::new).push((neighbor, m[i as usize][j as usize] + m[i as usize][(j-1) as usize]));
                    graph.entry(neighbor).or_insert_with(Vec::new).push((current, m[i as usize][j as usize] + m[i as usize][(j-1) as usize]));
                }
            }
        }

        let start = (start[0], start[1]);
        let end = (end[0], end[1]);
        let mut queue = VecDeque::new();
        let mut distances = HashMap::new();
        distances.insert(start, 0);
        queue.push_back(start);

        while let Some(node) = queue.pop_front() {
            if node == end {
                return *distances.get(&node).unwrap();
            }
            for &(neighbor, weight) in &graph[&node] {
                let new_distance = distances[&node] + weight;
                if distances.get(&neighbor).map_or(true, |&d| new_distance < d) {
                    distances.insert(neighbor, new_distance);
                    queue.push_back(neighbor);
                }
            }
        }

        -1
    }
}