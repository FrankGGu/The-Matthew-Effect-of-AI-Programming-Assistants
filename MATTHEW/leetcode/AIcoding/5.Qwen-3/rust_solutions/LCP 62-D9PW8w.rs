impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn is_valid_triplet(a: i32, b: i32, c: i32) -> bool {
        (a + b > c) && (a + c > b) && (b + c > a)
    }

    pub fn largest_triplet_product(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_by(|a, b| b.cmp(a));
        let mut max1 = nums[0];
        let mut max2 = nums[1];
        let mut max3 = nums[2];

        if nums.len() >= 3 {
            return max1 * max2 * max3;
        }

        -1
    }

    pub fn find_center(edges: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            *count.entry(u).or_insert(0) += 1;
            *count.entry(v).or_insert(0) += 1;
        }

        for (key, value) in count {
            if value == edges.len() {
                return key;
            }
        }

        -1
    }

    pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut parent = vec![0; n + 1];

        for i in 0..=n {
            parent[i] = i;
        }

        fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
            if parent[x as usize] != x {
                parent[x as usize] = find(parent, parent[x as usize]);
            }
            parent[x as usize]
        }

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            let root_u = find(&mut parent, u);
            let root_v = find(&mut parent, v);
            if root_u == root_v {
                return edge;
            }
            parent[root_v as usize] = root_u;
        }

        vec![]
    }

    pub fn find_redundant_connection_in_cycle(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut graph = vec![vec![]; n + 1];

        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            graph[u as usize].push(v);
            graph[v as usize].push(u);
        }

        let mut visited = vec![false; n + 1];
        let mut parent = vec![0; n + 1];
        let mut result = vec![];

        fn dfs(
            graph: &Vec<Vec<i32>>,
            visited: &mut Vec<bool>,
            parent: &mut Vec<i32>,
            node: i32,
            target: i32,
            result: &mut Vec<i32>,
        ) -> bool {
            visited[node as usize] = true;
            for &neighbor in &graph[node as usize] {
                if !visited[neighbor as usize] {
                    parent[neighbor as usize] = node;
                    if dfs(graph, visited, parent, neighbor, target, result) {
                        return true;
                    }
                } else if neighbor != parent[node as usize] {
                    result.push(node);
                    result.push(neighbor);
                    return true;
                }
            }
            false
        }

        for i in 1..=n {
            if !visited[i] {
                dfs(&graph, &mut visited, &mut parent, i, i, &mut result);
                if !result.is_empty() {
                    break;
                }
            }
        }

        result
    }

    pub fn find_smallest_set_of_vertices(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut in_degree = vec![0; n as usize];
        for edge in &edges {
            let v = edge[1];
            in_degree[v as usize] += 1;
        }

        let mut result = vec![];
        for i in 0..n {
            if in_degree[i as usize] == 0 {
                result.push(i);
            }
        }

        result
    }

    pub fn min_cost_to_connect_all_nodes(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let mut edges = connections;
        edges.sort_by(|a, b| a[2].cmp(&b[2]));

        let mut parent = vec![0; n as usize];
        for i in 0..n {
            parent[i as usize] = i;
        }

        fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
            if parent[x as usize] != x {
                parent[x as usize] = find(parent, parent[x as usize]);
            }
            parent[x as usize]
        }

        let mut total_cost = 0;
        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            let cost = edge[2];
            let root_u = find(&mut parent, u);
            let root_v = find(&mut parent, v);
            if root_u != root_v {
                parent[root_v as usize] = root_u;
                total_cost += cost;
            }
        }

        let root = find(&mut parent, 0);
        for i in 1..n {
            if find(&mut parent, i) != root {
                return -1;
            }
        }

        total_cost
    }

    pub fn valid_tree(n: i32, edges: Vec<Vec<i32>>) -> bool {
        if n == 0 {
            return true;
        }

        let mut graph = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            graph[u as usize].push(v);
            graph[v as usize].push(u);
        }

        let mut visited = vec![false; n as usize];
        let mut has_cycle = false;

        fn dfs(
            graph: &Vec<Vec<i32>>,
            visited: &mut Vec<bool>,
            parent: i32,
            node: i32,
            has_cycle: &mut bool,
        ) {
            visited[node as usize] = true;
            for &neighbor in &graph[node as usize] {
                if !visited[neighbor as usize] {
                    dfs(graph, visited, node, neighbor, has_cycle);
                } else if neighbor != parent {
                    *has_cycle = true;
                }
            }
        }

        dfs(&graph, &mut visited, -1, 0, &mut has_cycle);
        if *has_cycle {
            return false;
        }

        for i in 0..n {
            if !visited[i as usize] {
                return false;
            }
        }

        true
    }

    pub fn find_cheapest_price(n: i32, flights: Vec<Vec<i32>>, src: i32, dst: i32, k: i32) -> i32 {
        let mut prices = vec![i32::MAX; n as usize];
        prices[src as usize] = 0;

        for _ in 0..k + 1 {
            let mut temp_prices = prices.clone();
            let mut updated = false;
            for flight in &flights {
                let u = flight[0];
                let v = flight[1];
                let price = flight[2];
                if prices[u as usize] != i32::MAX && prices[u as usize] + price < temp_prices[v as usize] {
                    temp_prices[v as usize] = prices[u as usize] + price;
                    updated = true;
                }
            }
            prices = temp_prices;
            if !updated {
                break;
            }
        }

        if prices[dst as usize] == i32::MAX {
            -1
        } else {
            prices[dst as usize]
        }
    }

    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for time in &times {
            let u = time[0];
            let v = time[1];
            let w = time[2];
            graph[u as usize].push((v, w));
        }

        let mut dist = vec![i32::MAX; n as usize];
        dist[k as usize] = 0;

        let mut heap = std::collections::BinaryHeap::new();
        heap.push((0, k));

        while let Some((time, node)) = heap.pop() {
            if time > dist[node as usize] {
                continue;
            }
            for &(neighbor, weight) in &graph[node as usize] {
                if dist[neighbor as usize] > time + weight {
                    dist[neighbor as usize] = time + weight;
                    heap.push
}