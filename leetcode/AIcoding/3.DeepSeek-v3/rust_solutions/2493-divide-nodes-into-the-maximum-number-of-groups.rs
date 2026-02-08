use std::collections::{VecDeque, HashSet, HashMap};

impl Solution {
    pub fn magnificent_sets(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited = vec![false; n + 1];
        let mut components = vec![];

        for i in 1..=n {
            if !visited[i] {
                let mut queue = VecDeque::new();
                let mut component = vec![];
                queue.push_back(i);
                visited[i] = true;
                component.push(i);

                while let Some(u) = queue.pop_front() {
                    for &v in &adj[u] {
                        if !visited[v] {
                            visited[v] = true;
                            queue.push_back(v);
                            component.push(v);
                        }
                    }
                }
                components.push(component);
            }
        }

        let mut max_groups = 0;

        for component in components {
            let mut current_max = 0;
            for &start in &component {
                let mut groups = vec![0; n + 1];
                let mut queue = VecDeque::new();
                queue.push_back(start);
                groups[start] = 1;
                let mut valid = true;
                let mut local_max = 1;

                while let Some(u) = queue.pop_front() {
                    for &v in &adj[u] {
                        if groups[v] == 0 {
                            groups[v] = groups[u] + 1;
                            local_max = local_max.max(groups[v]);
                            queue.push_back(v);
                        } else if (groups[v] - groups[u]).abs() != 1 {
                            valid = false;
                            break;
                        }
                    }
                    if !valid {
                        break;
                    }
                }

                if valid {
                    current_max = current_max.max(local_max);
                }
            }

            if current_max == 0 {
                return -1;
            }
            max_groups += current_max;
        }

        max_groups
    }
}