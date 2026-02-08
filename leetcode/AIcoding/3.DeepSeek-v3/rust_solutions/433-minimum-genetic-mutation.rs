use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_mutation(start: String, end: String, bank: Vec<String>) -> i32 {
        let mut bank_set: HashSet<String> = bank.into_iter().collect();
        if !bank_set.contains(&end) {
            return -1;
        }
        let mut queue = VecDeque::new();
        queue.push_back((start.clone(), 0));
        bank_set.remove(&start);
        let choices = ['A', 'C', 'G', 'T'];

        while let Some((current, steps)) = queue.pop_front() {
            if current == end {
                return steps;
            }
            for i in 0..current.len() {
                for &c in &choices {
                    let mut next = current.clone();
                    next.replace_range(i..i+1, &c.to_string());
                    if bank_set.contains(&next) {
                        bank_set.remove(&next);
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }
        -1
    }
}