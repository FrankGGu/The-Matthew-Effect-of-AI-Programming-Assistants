use std::collections::{HashMap, VecDeque, HashSet};

impl Solution {
    pub fn alien_order(words: Vec<String>) -> String {
        if words.is_empty() {
            return String::new();
        }

        let mut adj: HashMap<char, HashSet<char>> = HashMap::new();
        let mut in_degree: HashMap<char, i32> = HashMap::new();
        let mut all_chars: HashSet<char> = HashSet::new();

        for word in &words {
            for c in word.chars() {
                all_chars.insert(c);
                in_degree.entry(c).or_insert(0);
            }
        }

        for i in 0..words.len() - 1 {
            let w1 = &words[i];
            let w2 = &words[i+1];

            let mut found_diff = false;
            let mut w1_chars = w1.chars();
            let mut w2_chars = w2.chars();

            loop {
                match (w1_chars.next(), w2_chars.next()) {
                    (Some(c1), Some(c2)) => {
                        if c1 != c2 {
                            if adj.entry(c1).or_insert_with(HashSet::new).insert(c2) {
                                *in_degree.get_mut(&c2).unwrap() += 1;
                            }
                            found_diff = true;
                            break;
                        }
                    },
                    (Some(_), None) => {
                        return String::new();
                    },
                    (None, Some(_)) => {
                        break;
                    },
                    (None, None) => {
                        break;
                    },
                }
            }
        }

        let mut queue: VecDeque<char> = VecDeque::new();
        for (&c, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(c);
            }
        }

        let mut result = String::new();
        while let Some(u) = queue.pop_front() {
            result.push(u);

            if let Some(neighbors) = adj.get(&u) {
                for &v in neighbors {
                    *in_degree.get_mut(&v).unwrap() -= 1;
                    if *in_degree.get(&v).unwrap() == 0 {
                        queue.push_back(v);
                    }
                }
            }
        }

        if result.len() == all_chars.len() {
            result
        } else {
            String::new()
        }
    }
}