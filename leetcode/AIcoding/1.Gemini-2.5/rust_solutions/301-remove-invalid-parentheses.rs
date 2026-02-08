use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn remove_invalid_parentheses(s: String) -> Vec<String> {
        let mut results: HashSet<String> = HashSet::new();
        let mut queue: VecDeque<String> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();

        queue.push_back(s.clone());
        visited.insert(s);

        let mut found_valid_at_this_depth = false;

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut next_level_candidates: Vec<String> = Vec::new();

            for _ in 0..level_size {
                let current_s = queue.pop_front().unwrap();

                if Self::is_valid(&current_s) {
                    results.insert(current_s.clone());
                    found_valid_at_this_depth = true;
                }

                if !found_valid_at_this_depth {
                    for i in 0..current_s.len() {
                        let c = current_s.chars().nth(i).unwrap();
                        if c != '(' && c != ')' {
                            continue;
                        }

                        if i > 0 && (c == '(' || c == ')') && current_s.chars().nth(i - 1).unwrap() == c {
                            continue;
                        }

                        let mut next_s_chars: Vec<char> = current_s.chars().collect();
                        next_s_chars.remove(i);
                        let next_s: String = next_s_chars.into_iter().collect();

                        if !visited.contains(&next_s) {
                            visited.insert(next_s.clone());
                            next_level_candidates.push(next_s);
                        }
                    }
                }
            }

            if found_valid_at_this_depth {
                break;
            } else {
                for candidate in next_level_candidates {
                    queue.push_back(candidate);
                }
            }
        }

        results.into_iter().collect()
    }

    fn is_valid(s: &str) -> bool {
        let mut balance = 0;
        for c in s.chars() {
            match c {
                '(' => balance += 1,
                ')' => {
                    balance -= 1;
                    if balance < 0 {
                        return false;
                    }
                }
                _ => {}
            }
        }
        balance == 0
    }
}