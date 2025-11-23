use std::collections::HashSet;
use std::collections::VecDeque;

impl Solution {
    pub fn min_mutation(start: String, end: String, bank: Vec<String>) -> i32 {
        let bank_set: HashSet<String> = bank.into_iter().collect();
        if !bank_set.contains(&end) {
            return -1;
        }

        let gene_chars = ['A', 'C', 'G', 'T'];
        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = HashSet::new();
        visited.insert(start.clone());

        while let Some((current, mutations)) = queue.pop_front() {
            if current == end {
                return mutations;
            }

            for i in 0..8 {
                for &ch in &gene_chars {
                    let mut next = current.clone().into_bytes();
                    next[i] = ch as u8;
                    let next_str = String::from_utf8(next).unwrap();
                    if bank_set.contains(&next_str) && !visited.contains(&next_str) {
                        visited.insert(next_str.clone());
                        queue.push_back((next_str, mutations + 1));
                    }
                }
            }
        }

        -1
    }
}