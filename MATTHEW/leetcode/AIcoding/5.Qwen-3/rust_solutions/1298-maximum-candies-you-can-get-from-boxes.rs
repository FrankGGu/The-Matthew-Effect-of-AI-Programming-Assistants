impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn max_candies(boxes: Vec<String>, release_hours: Vec<i32>, passwords: Vec<String>) -> i32 {
        let n = boxes.len();
        let mut graph = vec![vec![]; n];
        let mut password_map = std::collections::HashMap::new();
        let mut hour_map = std::collections::HashMap::new();

        for i in 0..n {
            password_map.insert(i, passwords[i].clone());
            hour_map.insert(i, release_hours[i]);
        }

        for i in 0..n {
            for j in 0..n {
                if i != j && boxes[i].contains(&boxes[j][0..1]) {
                    graph[i].push(j);
                }
            }
        }

        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        let mut has_key = vec![false; n];
        let mut result = 0;

        for i in 0..n {
            if release_hours[i] == 0 {
                queue.push_back(i);
                visited[i] = true;
            }
        }

        while let Some(current) = queue.pop_front() {
            result += boxes[current].len() as i32;
            for &neighbor in &graph[current] {
                if !visited[neighbor] && has_key[neighbor] {
                    visited[neighbor] = true;
                    queue.push_back(neighbor);
                }
            }

            for i in 0..n {
                if !visited[i] && !has_key[i] && password_map[i] == boxes[current] {
                    has_key[i] = true;
                    if release_hours[i] <= 0 {
                        visited[i] = true;
                        queue.push_back(i);
                    }
                }
            }
        }

        result
    }
}
}