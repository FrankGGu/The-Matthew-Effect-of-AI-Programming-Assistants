use std::collections::{VecDeque, HashSet};

struct Solution;

impl Solution {
    pub fn count_paths(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;

        // 1. Sieve of Eratosthenes to find primes up to n
        let mut is_prime = vec![true; n + 1];
        if n >= 0 { is_prime[0] = false; }
        if n >= 1 { is_prime[1] = false; } // 1 is not prime
        for i in 2..=(n as f64).sqrt() as usize {
            if is_prime[i] {
                for j in (i * i..=n).step_by(i) {
                    is_prime[j] = false;
                }
            }
        }

        // 2. Build adjacency list
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_valid_paths: i64 = 0;

        // `prime_adj_counts[p]` stores the sum of sizes of non-prime components
        // that have been processed so far and are adjacent to prime `p`.
        let mut prime_adj_counts: Vec<i64> = vec![0; n + 1];

        // `visited_non_prime_nodes[u]` is true if non-prime node `u` has been
        // visited as part of some non-prime component.
        let mut visited_non_prime_nodes = vec![false; n + 1];

        // 3. Iterate through each node from 1 to n
        for i in 1..=n {
            if is_prime[i] { // If node i is prime, it cannot be the start of a non-prime component
                continue;
            }
            if visited_non_prime_nodes[i] { // If non-prime node i has already been processed
                continue;
            }

            // Found a new unvisited non-prime node, start BFS to find its component
            let mut current_component_size: i64 = 0;
            let mut q: VecDeque<usize> = VecDeque::new();
            let mut prime_neighbors_of_component: HashSet<usize> = HashSet::new();

            q.push_back(i);
            visited_non_prime_nodes[i] = true;

            while let Some(u) = q.pop_front() {
                current_component_size += 1;
                for &v in &adj[u] {
                    if is_prime[v] {
                        prime_neighbors_of_component.insert(v);
                    } else if !visited_non_prime_nodes[v] {
                        visited_non_prime_nodes[v] = true;
                        q.push_back(v);
                    }
                }
            }

            // Now `current_component_size` is the size of the non-prime component
            // and `prime_neighbors_of_component` contains all primes adjacent to it.

            // For each prime `p` adjacent to this component:
            // 1. Paths of type `C_old - p - C_new`:
            //    `prime_adj_counts[p]` stores the sum of sizes of all *previous* non-prime components
            //    adjacent to `p`. Multiplying by `current_component_size` gives paths between them.
            // 2. Update `prime_adj_counts[p]` for future components.
            for &p in &prime_neighbors_of_component {
                total_valid_paths += current_component_size * prime_adj_counts[p];
                prime_adj_counts[p] += current_component_size;
            }
        }

        // 4. Add paths of type `C - p` (where C is a non-prime component, p is a prime)
        // These are paths where one endpoint is in a non-prime component and the other is a prime.
        // `prime_adj_counts[p]` now stores the total sum of sizes of all non-prime components
        // adjacent to prime `p`. This sum represents the number of paths of type `x - ... - p`
        // where `x` is in any non-prime component adjacent to `p`.
        for count in prime_adj_counts.iter() {
            total_valid_paths += count;
        }

        total_valid_paths
    }
}