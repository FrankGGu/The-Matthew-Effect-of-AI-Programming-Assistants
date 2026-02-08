struct Solution;

impl Solution {
    pub fn loud_and_rich(quiet: Vec<i32>, richer: Vec<Vec<i32>>) -> Vec<i32> {
        let n = quiet.len();

        // parent_adj[u] will store all people v such that v is richer than u (v -> u).
        // This represents the reverse graph where edges point from richer to poorer.
        let mut parent_adj: Vec<Vec<usize>> = vec![vec![]; n];
        for relation in richer {
            let u_richer = relation[0] as usize; // The person who is richer
            let v_poorer = relation[1] as usize; // The person who is poorer
            parent_adj[v_poorer].push(u_richer); // Add richer person 'u_richer' to 'v_poorer's parent_adj list.
                                                 // This means u_richer is an ancestor of v_poorer in the richness hierarchy.
        }

        // ans[i] will store the index of the quietest person j such that j is richer than or equal to i.
        // Initialize ans[i] to i itself. This also serves as an "unvisited" marker for our DFS.
        let mut ans: Vec<usize> = (0..n).collect();

        // Perform DFS for each person to find their quietest richer or equal person.
        // The DFS function will memoize results in the 'ans' array.
        for i in 0..n {
            Self::dfs(i, &quiet, &parent_adj, &mut ans);
        }

        // Convert the usize vector to i32 vector as required by the problem.
        ans.into_iter().map(|x| x as i32).collect()
    }

    // Helper DFS function to find the quietest richer or equal person for 'u'.
    fn dfs(u: usize, quiet: &Vec<i32>, parent_adj: &Vec<Vec<usize>>, ans: &mut Vec<usize>) -> usize {
        // If ans[u] is not u, it means we have already computed the answer for u
        // (i.e., it was updated from its initial value 'u'). This is the memoization step.
        if ans[u] != u {
            return ans[u];
        }

        // Initialize the current quietest person for u as u itself.
        let mut current_quietest_person = u;

        // Iterate through all people who are richer than u (parents of u in the richness graph).
        for &v_richer in parent_adj[u].iter() {
            // Recursively find the quietest person for v_richer.
            // This person will be an ancestor of u (or v_richer itself).
            let ancestor_quietest_person = Self::dfs(v_richer, quiet, parent_adj, ans);

            // Compare quietness. If ancestor_quietest_person is quieter, update.
            if quiet[ancestor_quietest_person] < quiet[current_quietest_person] {
                current_quietest_person = ancestor_quietest_person;
            } else if quiet[ancestor_quietest_person] == quiet[current_quietest_person] {
                // If quietness is equal, choose the one with the smaller index as per problem statement.
                if ancestor_quietest_person < current_quietest_person {
                    current_quietest_person = ancestor_quietest_person;
                }
            }
        }

        // Store the computed quietest person for u in ans[u].
        ans[u] = current_quietest_person;
        ans[u]
    }
}