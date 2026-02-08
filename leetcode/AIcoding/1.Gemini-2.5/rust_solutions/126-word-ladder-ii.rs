use std::collections::{VecDeque, HashMap, HashSet};

impl Solution {
    pub fn find_ladders(begin_word: String, end_word: String, word_list: Vec<String>) -> Vec<Vec<String>> {
        if begin_word == end_word {
            return vec![vec![begin_word]];
        }

        let mut word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return vec![];
        }

        // Add begin_word to the set if it's not there, as it's a valid starting point.
        // This is important for neighbor generation to find words from begin_word.
        word_set.insert(begin_word.clone());

        // BFS to build the graph and find shortest distances
        let mut queue: VecDeque<String> = VecDeque::new();
        let mut distances: HashMap<String, usize> = HashMap::new();
        // adj[u] will store all words v such that v is one edit distance from u AND dist(v) == dist(u) + 1
        let mut adj: HashMap<String, Vec<String>> = HashMap::new();

        queue.push_back(begin_word.clone());
        distances.insert(begin_word.clone(), 0);

        let mut found_end = false;

        while !queue.is_empty() && !found_end {
            let level_size = queue.len();
            // Words to be added to the queue for the next level.
            // Using a HashSet here ensures each word is only added once per level.
            let mut next_level_words_to_queue: HashSet<String> = HashSet::new(); 

            for _ in 0..level_size {
                let u = queue.pop_front().unwrap();
                let u_dist = *distances.get(&u).unwrap();

                // Generate neighbors
                let mut chars: Vec<char> = u.chars().collect();
                for i in 0..chars.len() {
                    let original_char = chars[i];
                    for c_code in 0..26 { // 'a' through 'z'
                        let c = (b'a' + c_code) as char;
                        if c == original_char {
                            continue;
                        }
                        chars[i] = c;
                        let v: String = chars.iter().collect();

                        if word_set.contains(&v) {
                            // Case 1: v has not been visited yet, or visited at a longer distance.
                            // This means we found a shortest path to v.
                            if distances.get(&v).map_or(true, |&d| d > u_dist + 1) {
                                distances.insert(v.clone(), u_dist + 1);
                                next_level_words_to_queue.insert(v.clone()); // Schedule for next level
                                adj.entry(u.clone()).or_insert(vec![]).push(v.clone());
                                if v == end_word {
                                    found_end = true;
                                }
                            } 
                            // Case 2: v has been visited at the same shortest distance.
                            // This means we found an alternative shortest path to v.
                            else if distances.get(&v).map_or(false, |&d| d == u_dist + 1) {
                                adj.entry(u.clone()).or_insert(vec![]).push(v.clone());
                            }
                            // Case 3: v has been visited at a shorter distance. Ignore this path.
                        }
                    }
                    chars[i] = original_char; // backtrack
                }
            }
            // Add all unique words for the next level to the queue
            for word in next_level_words_to_queue {
                queue.push_back(word);
            }
        }

        // If end_word was not reachable, return empty
        if !found_end {
            return vec![];
        }

        // DFS to reconstruct all shortest paths
        let mut results: Vec<Vec<String>> = Vec::new();
        let mut current_path: Vec<String> = Vec::new();
        current_path.push(begin_word.clone());

        Self::dfs_find_paths(&begin_word, &end_word, &adj, &mut current_path, &mut results);

        results
    }

    fn dfs_find_paths(
        current_word: &String,
        end_word: &String,
        adj: &HashMap<String, Vec<String>>,
        current_path: &mut Vec<String>,
        results: &mut Vec<Vec<String>>,
    ) {
        if current_word == end_word {
            results.push(current_path.clone());
            return;
        }

        // Only proceed if there are neighbors in the shortest path graph
        if let Some(neighbors) = adj.get(current_word) {
            for neighbor in neighbors {
                current_path.push(neighbor.clone());
                Self::dfs_find_paths(neighbor, end_word, adj, current_path, results);
                current_path.pop(); // backtrack
            }
        }
    }
}