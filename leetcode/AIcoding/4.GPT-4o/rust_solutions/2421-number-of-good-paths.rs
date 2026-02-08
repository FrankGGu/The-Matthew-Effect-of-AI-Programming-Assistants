use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn number_of_good_paths(vals: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = vals.len();
        let mut graph = vec![vec![]; n];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        let mut val_map: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut good_paths = 0;

        for (i, &val) in vals.iter().enumerate() {
            val_map.entry(val).or_insert(vec![]).push(i as i32);
        }

        let mut visited = vec![false; n];

        for &val in vals.iter().copied().collect::<HashSet<_>>().iter().collect::<Vec<_>>().iter() {
            let nodes = val_map[val].clone();
            for &node in &nodes {
                if !visited[node as usize] {
                    Self::dfs(node, &graph, &mut visited, &mut parent, &mut size);
                }
            }
            let mut count_map = HashMap::new();
            for &node in &nodes {
                let root = Self::find(node, &mut parent);
                *count_map.entry(root).or_insert(0) += 1;
            }
            for &count in count_map.values() {
                good_paths += count * (count + 1) / 2;
            }
        }

        good_paths
    }

    fn dfs(node: i32, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, parent: &mut Vec<i32>, size: &mut Vec<i32>) {
        visited[node as usize] = true;
        for &neighbor in &graph[node as usize] {
            if !visited[neighbor as usize] {
                parent[neighbor as usize] = node;
                Self::dfs(neighbor, graph, visited, parent, size);
                size[node as usize] += size[neighbor as usize];
            }
        }
    }

    fn find(x: i32, parent: &mut Vec<i32>) -> i32 {
        if parent[x as usize] != x {
            parent[x as usize] = Self::find(parent[x as usize], parent);
        }
        parent[x as usize]
    }
}