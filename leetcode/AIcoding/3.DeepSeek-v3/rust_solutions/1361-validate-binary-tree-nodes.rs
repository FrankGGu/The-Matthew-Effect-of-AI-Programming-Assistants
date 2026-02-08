use std::collections::HashSet;

impl Solution {
    pub fn validate_binary_tree_nodes(n: i32, left_child: Vec<i32>, right_child: Vec<i32>) -> bool {
        let n = n as usize;
        let mut parent = vec![-1; n];
        let mut has_parent = HashSet::new();

        for i in 0..n {
            let left = left_child[i] as usize;
            let right = right_child[i] as usize;

            if left != std::usize::MAX {
                if parent[left] != -1 || has_parent.contains(&left) {
                    return false;
                }
                parent[left] = i as i32;
                has_parent.insert(left);
            }

            if right != std::usize::MAX {
                if parent[right] != -1 || has_parent.contains(&right) {
                    return false;
                }
                parent[right] = i as i32;
                has_parent.insert(right);
            }
        }

        let root_count = (0..n).filter(|&i| parent[i] == -1 && !has_parent.contains(&i)).count();
        root_count == 1 && has_parent.len() == n - 1
    }
}