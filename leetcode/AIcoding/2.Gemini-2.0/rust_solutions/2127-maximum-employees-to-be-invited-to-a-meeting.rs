impl Solution {
    pub fn maximum_employees(favorite: Vec<i32>) -> i32 {
        let n = favorite.len();
        let mut adj = vec![Vec::new(); n];
        let mut indegree = vec![0; n];
        for i in 0..n {
            adj[favorite[i] as usize].push(i);
            indegree[favorite[i] as usize] += 1;
        }

        let mut queue = std::collections::VecDeque::new();
        for i in 0..n {
            if indegree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut depth = vec![0; n];
        let mut ans1 = 0;
        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if favorite[v] as usize != u {
                    depth[v] = depth[u] + 1;
                    indegree[v] -= 1;
                    if indegree[v] == 0 {
                        queue.push_back(v);
                    }
                }
            }
        }

        let mut ans2 = 0;
        for i in 0..n {
            if indegree[i] > 0 {
                let j = favorite[i] as usize;
                if favorite[j] as usize == i {
                    ans2 += depth[i] + depth[j] + 2;
                    indegree[i] = 0;
                    indegree[j] = 0;
                }
            }
        }

        let mut visited = vec![false; n];
        let mut ans3 = 0;
        for i in 0..n {
            if indegree[i] > 0 {
                let mut curr = i;
                let mut count = 0;
                while !visited[curr] {
                    visited[curr] = true;
                    curr = favorite[curr] as usize;
                    count += 1;
                }
                ans3 = ans3.max(count);
            }
        }

        ans1 = ans2.max(ans3);

        ans1 as i32
    }
}