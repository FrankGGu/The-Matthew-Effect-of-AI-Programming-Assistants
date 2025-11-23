use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn alien_order(words: Vec<String>) -> String {
        let mut adj: HashMap<char, Vec<char>> = HashMap::new();
        let mut indegree: HashMap<char, i32> = HashMap::new();

        for word in &words {
            for c in word.chars() {
                indegree.entry(c).or_insert(0);
            }
        }

        for i in 0..words.len() - 1 {
            let w1 = &words[i];
            let w2 = &words[i + 1];
            let min_len = std::cmp::min(w1.len(), w2.len());

            if w1.len() > w2.len() && w1[..min_len] == w2[..min_len] {
                return String::new();
            }

            for j in 0..min_len {
                if w1.chars().nth(j) != w2.chars().nth(j) {
                    let c1 = w1.chars().nth(j).unwrap();
                    let c2 = w2.chars().nth(j).unwrap();

                    adj.entry(c1).or_insert(Vec::new());
                    let neighbors = adj.get_mut(&c1).unwrap();
                    if !neighbors.contains(&c2) {
                        neighbors.push(c2);
                        *indegree.entry(c2).or_insert(0) += 1;
                    }

                    break;
                }
            }
        }

        let mut queue: Vec<char> = indegree.iter().filter(|(_, &v)| v == 0).map(|(&k, _)| k).collect();
        let mut result = String::new();

        while !queue.is_empty() {
            let c = queue.remove(0);
            result.push(c);

            if let Some(neighbors) = adj.get(&c) {
                for &neighbor in neighbors {
                    *indegree.get_mut(&neighbor).unwrap() -= 1;
                    if *indegree.get(&neighbor).unwrap() == 0 {
                        queue.push(neighbor);
                    }
                }
            }
        }

        if result.len() == indegree.len() {
            result
        } else {
            String::new()
        }
    }
}

struct Solution;