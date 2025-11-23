impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn ways_to_reconstruct_tree(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut degree = HashMap::new();
        let mut adj = HashMap::new();

        for &num in &nums {
            degree.entry(num).or_insert(0);
        }

        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            adj.entry(u).or_insert_with(HashSet::new).insert(v);
            adj.entry(v).or_insert_with(HashSet::new).insert(u);
            *degree.get_mut(&u).unwrap() += 1;
            *degree.get_mut(&v).unwrap() += 1;
        }

        let mut root = -1;
        for &num in &nums {
            if degree[&num] == 0 {
                root = num;
                break;
            }
        }

        let mut visited = HashSet::new();
        let mut result = 0;

        fn dfs(
            node: i32,
            parent: i32,
            nums: &Vec<i32>,
            adj: &HashMap<i32, HashSet<i32>>,
            visited: &mut HashSet<i32>,
            count: &mut i32,
        ) {
            visited.insert(node);
            let mut children = vec![];
            for &neighbor in adj.get(&node).unwrap() {
                if neighbor != parent {
                    children.push(neighbor);
                }
            }

            for child in children {
                if !visited.contains(&child) {
                    dfs(child, node, nums, adj, visited, count);
                }
            }

            if children.len() == 0 {
                *count += 1;
            } else {
                let mut valid = true;
                for child in &children {
                    if !nums.contains(child) {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    *count += 1;
                }
            }
        }

        dfs(root, -1, &nums, &adj, &mut visited, &mut result);

        result
    }
}
}