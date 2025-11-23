use std::collections::HashSet;

impl Solution {
    pub fn root_count(edges: Vec<Vec<i32>>, guesses: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = edges.len() + 1;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut guesses_set: HashSet<(usize, usize)> = HashSet::new();
        for guess in &guesses {
            guesses_set.insert((guess[0] as usize, guess[1] as usize));
        }

        let mut correct_guesses = 0;
        for guess in &guesses {
            if guess[0] == edges[0][0] && guess[1] == edges[0][1] {
                correct_guesses += 1;
            }
        }

        fn dfs(
            node: usize,
            parent: usize,
            adj: &Vec<Vec<usize>>,
            guesses_set: &HashSet<(usize, usize)>,
        ) -> i32 {
            let mut count = 0;
            for &neighbor in &adj[node] {
                if neighbor != parent {
                    if guesses_set.contains(&(node, neighbor)) {
                        count += 1;
                    }
                    count += dfs(neighbor, node, adj, guesses_set);
                }
            }
            count
        }

        let initial_correct = dfs(edges[0][0] as usize, edges[0][1] as usize, &adj, &guesses_set) + (if guesses_set.contains(&(edges[0][1] as usize, edges[0][0] as usize)) { 1 } else { 0 });

        fn dfs2(
            node: usize,
            parent: usize,
            adj: &Vec<Vec<usize>>,
            guesses_set: &HashSet<(usize, usize)>,
            correct_guesses: i32,
            mut result: &mut i32
        ) -> i32 {
            let mut count = 0;
            for &neighbor in &adj[node] {
                if neighbor != parent {
                    let mut new_correct_guesses = correct_guesses;
                    if guesses_set.contains(&(node, neighbor)) {
                        new_correct_guesses -= 1;
                    }
                    if guesses_set.contains(&(neighbor, node)) {
                        new_correct_guesses += 1;
                    }
                    if new_correct_guesses >= *result{
                         *result = new_correct_guesses;
                    }

                    count += dfs2(neighbor, node, adj, guesses_set, new_correct_guesses, &mut *result);
                }
            }
            count
        }

        let mut count = 0;
        let mut res = 0;
        for i in 0..n {
            let mut correct = 0;
            for guess in &guesses {
               if guesses_set.contains(&(guess[0] as usize, guess[1] as usize)){
                   correct +=1;
               } 
            }

            fn dfs3(node: usize, parent: usize, adj: &Vec<Vec<usize>>, guesses_set: &HashSet<(usize, usize)>) -> i32 {
                let mut count = 0;
                for &neighbor in &adj[node] {
                    if neighbor != parent {
                        if guesses_set.contains(&(node, neighbor)) {
                            count += 1;
                        }
                        count += dfs3(neighbor, node, adj, guesses_set);
                    }
                }
                count
            }
            let initial_correct = dfs3(i, n, &adj, &guesses_set);

            if initial_correct >= k {
                count += 1;
            }
        }

        count
    }
}