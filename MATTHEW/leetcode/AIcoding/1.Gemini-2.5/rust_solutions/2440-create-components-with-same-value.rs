struct Solution;

impl Solution {
    pub fn create_components_with_same_value(values: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = values.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let total_sum: i32 = values.iter().sum();

        let mut divisors: Vec<i32> = Vec::new();
        for i in 1..=((total_sum as f64).sqrt() as i32) {
            if total_sum % i == 0 {
                divisors.push(i);
                if i * i != total_sum {
                    divisors.push(total_sum / i);
                }
            }
        }
        divisors.sort_unstable();

        fn dfs_check(
            u: usize,
            p: usize, // parent node, to avoid going back up
            target_sum: i32,
            adj: &Vec<Vec<usize>>,
            values: &Vec<i32>,
        ) -> i32 {
            let mut current_subtree_sum = values[u];

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let child_sum = dfs_check(v, u, target_sum, adj, values);
                if child_sum == -1 {
                    return -1; // Impossible path detected in a child subtree
                }
                current_subtree_sum += child_sum;
            }

            if current_subtree_sum > target_sum {
                return -1; // Subtree sum exceeds target_sum, impossible
            } else if current_subtree_sum == target_sum {
                return 0; // This subtree forms a complete component, its sum is "consumed"
            } else {
                return current_subtree_sum; // This subtree needs to be combined with its parent
            }
        }

        for &x in divisors.iter() {
            // The root's parent is an arbitrary value not in [0, n-1]. Using 'n' is safe.
            let result = dfs_check(0, n, x, &adj, &values);

            // If the DFS from root returns 0, it means the entire tree was successfully
            // partitioned into components of sum `x`.
            if result == 0 {
                return total_sum / x;
            }
        }

        // This line should theoretically be unreachable because total_sum itself is always
        // a valid `x` (resulting in k=1 component, the whole tree).
        1 
    }
}