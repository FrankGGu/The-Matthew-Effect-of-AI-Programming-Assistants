use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn find_ladders(
        begin_word: String,
        end_word: String,
        word_list: Vec<String>,
    ) -> Vec<Vec<String>> {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return vec![];
        }

        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut queue: VecDeque<String> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();
        let mut distance: HashMap<String, usize> = HashMap::new();

        queue.push_back(begin_word.clone());
        visited.insert(begin_word.clone());
        distance.insert(begin_word.clone(), 0);

        while !queue.is_empty() {
            let current_word = queue.pop_front().unwrap();
            let current_distance = distance[&current_word];

            for i in 0..current_word.len() {
                let mut next_word = current_word.clone();
                for ch in b'a'..=b'z' {
                    next_word.replace_range(i..i + 1, &(ch as char).to_string());
                    if word_set.contains(&next_word) {
                        if !visited.contains(&next_word) {
                            visited.insert(next_word.clone());
                            distance.insert(next_word.clone(), current_distance + 1);
                            queue.push_back(next_word.clone());
                        }

                        if !graph.contains_key(&current_word) {
                            graph.insert(current_word.clone(), vec![]);
                        }
                        graph.get_mut(&current_word).unwrap().push(next_word.clone());
                    }
                }
            }
        }

        let mut result: Vec<Vec<String>> = vec![];
        let mut path: Vec<String> = vec![begin_word.clone()];

        fn dfs(
            current_word: &String,
            end_word: &String,
            graph: &HashMap<String, Vec<String>>,
            path: &mut Vec<String>,
            result: &mut Vec<Vec<String>>,
            distance: &HashMap<String, usize>,
        ) {
            if current_word == end_word {
                result.push(path.clone());
                return;
            }

            if !graph.contains_key(current_word) {
                return;
            }

            for next_word in &graph[current_word] {
                if distance[next_word] == distance[current_word] + 1 {
                    path.push(next_word.clone());
                    dfs(next_word, end_word, graph, path, result, distance);
                    path.pop();
                }
            }
        }

        dfs(&begin_word, &end_word, &graph, &mut path, &mut result, &distance);

        result
    }
}