impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn min_mutations(
        start: String,
        end: String,
        bank: Vec<String>,
    ) -> i32 {
        let mut bank_set = HashSet::new();
        for gene in &bank {
            bank_set.insert(gene);
        }

        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = HashSet::new();
        visited.insert(start);

        let chars = ['A', 'C', 'G', 'T'];

        while let Some((current, steps)) = queue.pop_front() {
            if current == end {
                return steps;
            }

            for i in 0..current.len() {
                for &c in &chars {
                    let mut next = current.clone();
                    next.replace_range(i..i+1, &c.to_string());
                    if !visited.contains(&next) && bank_set.contains(&next) {
                        visited.insert(next.clone());
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}