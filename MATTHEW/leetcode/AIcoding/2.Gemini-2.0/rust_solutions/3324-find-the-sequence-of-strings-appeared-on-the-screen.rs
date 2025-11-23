impl Solution {
    pub fn find_sequence(n: i32, words: Vec<String>) -> Vec<String> {
        let mut adj: std::collections::HashMap<char, Vec<char>> = std::collections::HashMap::new();
        let mut in_degree: std::collections::HashMap<char, i32> = std::collections::HashMap::new();

        for word in &words {
            for c in word.chars() {
                in_degree.entry(c).or_insert(0);
            }
        }

        for i in 0..words.len() - 1 {
            let w1 = &words[i];
            let w2 = &words[i + 1];
            let mut j = 0;
            while j < w1.len() && j < w2.len() && w1.chars().nth(j) == w2.chars().nth(j) {
                j += 1;
            }
            if j < w1.len() && j < w2.len() {
                let c1 = w1.chars().nth(j).unwrap();
                let c2 = w2.chars().nth(j).unwrap();
                adj.entry(c1).or_insert(Vec::new()).push(c2);
                *in_degree.entry(c2).or_insert(0) += 1;
            } else if w1.len() > w2.len() {
                return Vec::new();
            }
        }

        let mut queue: std::collections::VecDeque<char> = std::collections::VecDeque::new();
        for (c, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(*c);
            }
        }

        let mut result: Vec<char> = Vec::new();
        while let Some(c) = queue.pop_front() {
            result.push(c);
            if let Some(neighbors) = adj.get(&c) {
                for &neighbor in neighbors {
                    *in_degree.get_mut(&neighbor).unwrap() -= 1;
                    if in_degree[&neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        if result.len() != in_degree.len() {
            return Vec::new();
        }

        result.into_iter().map(|c| c.to_string()).collect()
    }
}