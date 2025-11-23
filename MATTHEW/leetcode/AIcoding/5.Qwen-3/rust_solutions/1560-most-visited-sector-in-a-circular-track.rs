impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn most_visited(n: i32, rounds: Vec<i32>) -> Vec<i32> {
        let mut visited = HashSet::new();
        let mut current = 1;
        let mut end = rounds[rounds.len() - 1];

        for i in 0..rounds.len() - 1 {
            let start = rounds[i];
            let next = rounds[i + 1];

            while current != next {
                visited.insert(current);
                current = if current == n { 1 } else { current + 1 };
            }
        }

        while current != end {
            visited.insert(current);
            current = if current == n { 1 } else { current + 1 };
        }

        visited.insert(end);

        let mut result: Vec<i32> = visited.into_iter().collect();
        result.sort();
        result
    }
}
}