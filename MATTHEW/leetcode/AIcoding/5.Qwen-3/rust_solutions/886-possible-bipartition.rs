impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn possible_bipartition(mut n: i32, mut dislikes: Vec<Vec<i32>>) -> bool {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for d in &dislikes {
            graph.entry(d[0]).or_insert_with(Vec::new).push(d[1]);
            graph.entry(d[1]).or_insert_with(Vec::new).push(d[0]);
        }

        let mut color = vec![0; n as usize + 1];

        for i in 1..=n {
            if color[i as usize] == 0 {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                color[i as usize] = 1;

                while let Some(node) = queue.pop_front() {
                    if let Some(neighbors) = graph.get(&node) {
                        for &neighbor in neighbors {
                            if color[neighbor as usize] == 0 {
                                color[neighbor as usize] = 3 - color[node as usize];
                                queue.push_back(neighbor);
                            } else if color[neighbor as usize] == color[node as usize] {
                                return false;
                            }
                        }
                    }
                }
            }
        }

        true
    }
}
}