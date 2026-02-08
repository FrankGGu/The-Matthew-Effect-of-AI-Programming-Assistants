use std::collections::VecDeque;

impl Solution {
    pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        if n == 1 {
            return vec![0];
        }

        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        let mut degree: Vec<i32> = vec![0; n as usize];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut leaves: VecDeque<i32> = VecDeque::new();
        for i in 0..n as usize {
            if degree[i] == 1 {
                leaves.push_back(i as i32);
            }
        }

        let mut count = n;
        while count > 2 {
            let size = leaves.len();
            count -= size as i32;

            for _ in 0..size {
                let leaf = leaves.pop_front().unwrap() as usize;
                degree[leaf] -= 1;

                for &neighbor in &adj[leaf] {
                    let neighbor_usize = neighbor as usize;
                    degree[neighbor_usize] -= 1;
                    if degree[neighbor_usize] == 1 {
                        leaves.push_back(neighbor);
                    }
                }
            }
        }

        let mut result: Vec<i32> = Vec::new();
        while !leaves.is_empty() {
            result.push(leaves.pop_front().unwrap());
        }

        result
    }

    pub fn solve(n: i32, edges: Vec<Vec<i32>>, new_edge: Vec<i32>) -> i32 {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let u = new_edge[0] as usize;
        let v = new_edge[1] as usize;
        adj[u].push(v as i32);
        adj[v].push(u as i32);

        let mut max_diameter = 0;
        for start_node in 0..n {
            let mut visited: Vec<bool> = vec![false; n as usize];
            let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
            queue.push_back((start_node, 0));
            visited[start_node as usize] = true;

            while let Some((node, dist)) = queue.pop_front() {
                max_diameter = max_diameter.max(dist);

                for &neighbor in &adj[node as usize] {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }
        }

        max_diameter
    }

    pub fn find_min_diameter(n: i32, edges: Vec<Vec<i32>>, new_edge: Vec<i32>) -> i32 {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let centers1 = Self::find_min_height_trees(n, edges.clone());
        let centers2 = Self::find_min_height_trees(n, edges.clone());

        let mut diameter1 = 0;
        for &start_node in &centers1 {
            let mut visited: Vec<bool> = vec![false; n as usize];
            let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
            queue.push_back((start_node, 0));
            visited[start_node as usize] = true;
            let mut max_dist = 0;

            while let Some((node, dist)) = queue.pop_front() {
                max_dist = max_dist.max(dist);

                for &neighbor in &adj[node as usize] {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }
            diameter1 = diameter1.max(max_dist);
        }

        let mut diameter2 = 0;
        for &start_node in &centers2 {
            let mut visited: Vec<bool> = vec![false; n as usize];
            let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
            queue.push_back((start_node, 0));
            visited[start_node as usize] = true;
            let mut max_dist = 0;

            while let Some((node, dist)) = queue.pop_front() {
                max_dist = max_dist.max(dist);

                for &neighbor in &adj[node as usize] {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }
            diameter2 = diameter2.max(max_dist);
        }

        let center1 = centers1[0];
        let center2 = centers2[0];

        let mut new_edges = edges.clone();
        new_edges.push(new_edge.clone());

        let mut new_adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in &new_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            new_adj[u].push(v as i32);
            new_adj[v].push(u as i32);
        }

        let mut visited: Vec<bool> = vec![false; n as usize];
        let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
        queue.push_back((center1, 0));
        visited[center1 as usize] = true;
        let mut dist_to_center1: Vec<i32> = vec![i32::MAX; n as usize];
        dist_to_center1[center1 as usize] = 0;

        while let Some((node, dist)) = queue.pop_front() {
            dist_to_center1[node as usize] = dist;
            for &neighbor in &new_adj[node as usize] {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back((neighbor, dist + 1));
                }
            }
        }

        let mut visited: Vec<bool> = vec![false; n as usize];
        let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
        queue.push_back((center2, 0));
        visited[center2 as usize] = true;
        let mut dist_to_center2: Vec<i32> = vec![i32::MAX; n as usize];
        dist_to_center2[center2 as usize] = 0;

        while let Some((node, dist)) = queue.pop_front() {
            dist_to_center2[node as usize] = dist;
            for &neighbor in &new_adj[node as usize] {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back((neighbor, dist + 1));
                }
            }
        }

        let mut max_dist = 0