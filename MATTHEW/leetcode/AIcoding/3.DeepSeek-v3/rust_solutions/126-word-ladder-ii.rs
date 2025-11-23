use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn find_ladders(begin_word: String, end_word: String, word_list: Vec<String>) -> Vec<Vec<String>> {
        let mut word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return vec![];
        }
        word_set.remove(&begin_word);

        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut queue = VecDeque::new();
        queue.push_back(begin_word.clone());
        let mut found = false;

        while !queue.is_empty() && !found {
            let mut visited = HashSet::new();
            for _ in 0..queue.len() {
                let current = queue.pop_front().unwrap();
                let mut chars: Vec<char> = current.chars().collect();
                for i in 0..chars.len() {
                    let original = chars[i];
                    for c in 'a'..='z' {
                        chars[i] = c;
                        let next_word: String = chars.iter().collect();
                        if word_set.contains(&next_word) {
                            if next_word == end_word {
                                found = true;
                            }
                            if !visited.contains(&next_word) {
                                visited.insert(next_word.clone());
                                queue.push_back(next_word.clone());
                            }
                            graph.entry(current.clone()).or_default().push(next_word.clone());
                        }
                    }
                    chars[i] = original;
                }
            }
            for word in &visited {
                word_set.remove(word);
            }
        }

        let mut result = Vec::new();
        if found {
            let mut path = vec![begin_word];
            Self::dfs(&graph, &end_word, &mut path, &mut result);
        }
        result
    }

    fn dfs(graph: &HashMap<String, Vec<String>>, end_word: &str, path: &mut Vec<String>, result: &mut Vec<Vec<String>>) {
        let last = path.last().unwrap();
        if last == end_word {
            result.push(path.clone());
            return;
        }
        if let Some(neighbors) = graph.get(last) {
            for neighbor in neighbors {
                path.push(neighbor.clone());
                Self::dfs(graph, end_word, path, result);
                path.pop();
            }
        }
    }
}