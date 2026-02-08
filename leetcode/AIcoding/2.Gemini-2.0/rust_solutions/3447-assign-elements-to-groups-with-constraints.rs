impl Solution {
    pub fn solve(n: i32, group_sizes: Vec<i32>, constraints: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let k = group_sizes.len();
        let mut adj = vec![vec![]; k];
        for constraint in &constraints {
            let u = constraint[0] as usize;
            let v = constraint[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut assignments = vec![-1; n];

        fn is_valid(node: usize, group: i32, assignments: &Vec<i32>, adj: &Vec<Vec<usize>>, constraints: &Vec<Vec<i32>>, group_sizes: &Vec<i32>) -> bool {
            for &neighbor in &adj[node] {
                if assignments[neighbor] == group {
                    return false;
                }
            }
            true
        }

        fn backtrack(node: usize, assignments: &mut Vec<i32>, adj: &Vec<Vec<usize>>, group_sizes: &Vec<i32>, constraints: &Vec<Vec<i32>>) -> bool {
            if node == assignments.len() {
                let mut group_counts = vec![0; group_sizes.len()];
                for &assignment in assignments.iter() {
                    group_counts[assignment as usize] += 1;
                }

                for i in 0..group_sizes.len() {
                    if group_counts[i] != group_sizes[i] {
                        return false;
                    }
                }

                return true;
            }

            for group in 0..group_sizes.len() {
                if is_valid(node, group as i32, &assignments, &adj, &constraints, &group_sizes) {
                    assignments[node] = group as i32;
                    if backtrack(node + 1, assignments, adj, group_sizes, constraints) {
                        return true;
                    }
                    assignments[node] = -1;
                }
            }
            false
        }

        if backtrack(0, &mut assignments, &adj, &group_sizes, &constraints) {
            1
        } else {
            0
        }
    }
}