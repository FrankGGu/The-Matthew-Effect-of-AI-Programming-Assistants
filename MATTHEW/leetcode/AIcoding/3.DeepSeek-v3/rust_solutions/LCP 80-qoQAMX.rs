use std::collections::HashMap;

impl Solution {
    pub fn min_mutation(start: String, end: String, bank: Vec<String>) -> i32 {
        let mut bank_set: std::collections::HashSet<String> = bank.into_iter().collect();
        if !bank_set.contains(&end) {
            return -1;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back((start.clone(), 0));
        bank_set.remove(&start);

        let chars = vec!['A', 'C', 'G', 'T'];

        while let Some((current, steps)) = queue.pop_front() {
            if current == end {
                return steps;
            }

            for i in 0..current.len() {
                let mut current_chars: Vec<char> = current.chars().collect();
                for &c in &chars {
                    if current_chars[i] == c {
                        continue;
                    }
                    let original = current_chars[i];
                    current_chars[i] = c;
                    let next: String = current_chars.iter().collect();
                    if bank_set.contains(&next) {
                        queue.push_back((next.clone(), steps + 1));
                        bank_set.remove(&next);
                    }
                    current_chars[i] = original;
                }
            }
        }

        -1
    }
}