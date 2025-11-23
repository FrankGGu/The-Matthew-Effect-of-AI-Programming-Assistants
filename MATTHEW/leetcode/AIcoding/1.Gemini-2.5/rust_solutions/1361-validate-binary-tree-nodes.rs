use std::collections::VecDeque;

impl Solution {
    pub fn validate_binary_tree_nodes(n: i32, left_child: Vec<i32>, right_child: Vec<i32>) -> bool {
        let n_usize = n as usize;

        let mut in_degree = vec![0; n_usize];
        for i in 0..n_usize {
            if left_child[i] != -1 {
                let child_idx = left_child[i] as usize;
                in_degree[child_idx] += 1;
            }
            if right_child[i] != -1 {
                let child_idx = right_child[i] as usize;
                in_degree[child_idx] += 1;
            }
        }

        let mut root = -1;
        for i in 0..n_usize {
            if in_degree[i] == 0 {
                if root != -1 {
                    return false; 
                }
                root = i as i32;
            } else if in_degree[i] > 1 {
                return false; 
            }
        }

        if root == -1 {
            return false; 
        }

        let mut visited = vec![false; n_usize];
        let mut queue = VecDeque::new();
        let mut visited_count = 0;

        queue.push_back(root);
        visited[root as usize] = true;

        while let Some(node) = queue.pop_front() {
            visited_count += 1;

            let current_node_idx = node as usize;

            if left_child[current_node_idx] != -1 {
                let child = left_child[current_node_idx] as usize;
                if visited[child] {
                    return false; 
                }
                visited[child] = true;
                queue.push_back(child as i32);
            }

            if right_child[current_node_idx] != -1 {
                let child = right_child[current_node_idx] as usize;
                if visited[child] {
                    return false; 
                }
                visited[child] = true;
                queue.push_back(child as i32);
            }
        }

        visited_count == n_usize
    }
}