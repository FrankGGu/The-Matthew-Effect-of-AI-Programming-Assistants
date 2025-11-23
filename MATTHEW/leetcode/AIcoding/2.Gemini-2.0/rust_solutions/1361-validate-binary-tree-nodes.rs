use std::collections::HashSet;

impl Solution {
    pub fn validate_binary_tree_nodes(n: i32, left_child: Vec<i32>, right_child: Vec<i32>) -> bool {
        let n = n as usize;
        let mut indegrees = vec![0; n];
        for &child in &left_child {
            if child != -1 {
                indegrees[child as usize] += 1;
            }
        }
        for &child in &right_child {
            if child != -1 {
                indegrees[child as usize] += 1;
            }
        }

        let mut roots = Vec::new();
        for i in 0..n {
            if indegrees[i] == 0 {
                roots.push(i);
            }
        }

        if roots.len() != 1 {
            return false;
        }

        let root = roots[0];
        let mut visited = HashSet::new();
        let mut stack = vec![root];
        visited.insert(root);
        let mut count = 0;

        while let Some(node) = stack.pop() {
            count += 1;
            let left = left_child[node] as i32;
            if left != -1 {
                if visited.contains(&(left as usize)) {
                    return false;
                }
                visited.insert(left as usize);
                stack.push(left as usize);
            }

            let right = right_child[node] as i32;
            if right != -1 {
                if visited.contains(&(right as usize)) {
                    return false;
                }
                visited.insert(right as usize);
                stack.push(right as usize);
            }
        }

        count == n
    }
}