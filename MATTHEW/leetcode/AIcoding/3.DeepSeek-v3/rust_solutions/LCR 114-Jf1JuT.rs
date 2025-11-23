use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn alien_order(words: Vec<String>) -> String {
        let mut graph: HashMap<char, Vec<char>> = HashMap::new();
        let mut in_degree: HashMap<char, i32> = HashMap::new();

        for word in &words {
            for c in word.chars() {
                in_degree.entry(c).or_insert(0);
            }
        }

        for i in 0..words.len() - 1 {
            let word1 = words[i].as_bytes();
            let word2 = words[i + 1].as_bytes();
            let len = word1.len().min(word2.len());
            let mut found = false;
            for j in 0..len {
                let c1 = word1[j] as char;
                let c2 = word2[j] as char;
                if c1 != c2 {
                    graph.entry(c1).or_default().push(c2);
                    *in_degree.entry(c2).or_default() += 1;
                    found = true;
                    break;
                }
            }
            if !found && word1.len() > word2.len() {
                return String::new();
            }
        }

        let mut queue: VecDeque<char> = VecDeque::new();
        for (&c, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(c);
            }
        }

        let mut result = String::new();
        while let Some(c) = queue.pop_front() {
            result.push(c);
            if let Some(neighbors) = graph.get(&c) {
                for &neighbor in neighbors {
                    let degree = in_degree.get_mut(&neighbor).unwrap();
                    *degree -= 1;
                    if *degree == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        if result.len() == in_degree.len() {
            result
        } else {
            String::new()
        }
    }
}