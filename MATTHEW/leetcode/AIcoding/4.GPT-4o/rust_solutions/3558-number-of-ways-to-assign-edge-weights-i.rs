pub fn number_of_ways(n: i32, edges: Vec<Vec<i32>>, guesses: Vec<Vec<i32>>, k: i32) -> i32 {
    use std::collections::{HashMap, HashSet};

    let mut graph: HashMap<i32, HashSet<i32>> = HashMap::new();
    for edge in edges.iter() {
        graph.entry(edge[0]).or_insert(HashSet::new()).insert(edge[1]);
        graph.entry(edge[1]).or_insert(HashSet::new()).insert(edge[0]);
    }

    let mut guess_map: HashMap<(i32, i32), bool> = HashMap::new();
    for guess in guesses.iter() {
        guess_map.insert((guess[0], guess[1]), true);
        guess_map.insert((guess[1], guess[0]), true);
    }

    fn dfs(node: i32, parent: i32, graph: &HashMap<i32, HashSet<i32>>, guess_map: &HashMap<(i32, i32), bool>, k: i32, guesses: &mut Vec<i32>, count: &mut i32) {
        if guesses.len() == graph.len() as usize {
            let mut good_guesses = 0;
            for i in 0..guesses.len() - 1 {
                if guess_map.get(&(guesses[i], guesses[i + 1])).is_some() {
                    good_guesses += 1;
                }
            }
            if good_guesses >= k {
                *count += 1;
            }
            return;
        }

        for &neighbor in graph.get(&node).unwrap() {
            if neighbor != parent {
                guesses.push(neighbor);
                dfs(neighbor, node, graph, guess_map, k, guesses, count);
                guesses.pop();
            }
        }
    }

    let mut count = 0;
    let mut guesses_vec = vec![0];
    dfs(0, -1, &graph, &guess_map, k, &mut guesses_vec, &mut count);
    count
}