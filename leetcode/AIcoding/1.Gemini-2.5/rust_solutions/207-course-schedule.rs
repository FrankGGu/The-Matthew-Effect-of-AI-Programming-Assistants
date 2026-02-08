struct Solution;

impl Solution {
    pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
        let n = num_courses as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for prereq in prerequisites {
            let course = prereq[0] as usize;
            let prerequisite = prereq[1] as usize;
            adj[prerequisite].push(course);
        }

        // 0: unvisited
        // 1: visiting (currently in the recursion stack)
        // 2: visited (finished processing this node and its descendants)
        let mut visited_state: Vec<u8> = vec![0; n];

        for i in 0..n {
            if visited_state[i] == 0 {
                if !Self::dfs(i, &adj, &mut visited_state) {
                    return false;
                }
            }
        }

        true
    }

    fn dfs(node: usize, adj: &Vec<Vec<usize>>, visited_state: &mut Vec<u8>) -> bool {
        if visited_state[node] == 1 {
            return false;
        }
        if visited_state[node] == 2 {
            return true;
        }

        visited_state[node] = 1;

        for &neighbor in &adj[node] {
            if !Self::dfs(neighbor, adj, visited_state) {
                return false;
            }
        }

        visited_state[node] = 2;
        true
    }
}