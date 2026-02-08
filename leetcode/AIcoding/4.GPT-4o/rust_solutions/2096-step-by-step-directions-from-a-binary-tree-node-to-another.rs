use std::collections::HashMap;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn get_directions(root: Option<Box<TreeNode>>, start_value: i32, dest_value: i32) -> String {
        let mut parent_map = HashMap::new();
        let mut path_to_start = String::new();
        let mut path_to_dest = String::new();

        Self::dfs(&root, &mut parent_map);

        let start_node = Self::find_node(&root, start_value);
        let dest_node = Self::find_node(&root, dest_value);

        Self::find_path(&parent_map, start_node, &mut path_to_start);
        Self::find_path(&parent_map, dest_node, &mut path_to_dest);

        let start_path: Vec<_> = path_to_start.chars().collect();
        let dest_path: Vec<_> = path_to_dest.chars().collect();

        let mut i = 0;
        while i < start_path.len() && i < dest_path.len() && start_path[i] == dest_path[i] {
            i += 1;
        }

        let up_moves = start_path.len() - i;
        let down_moves = dest_path.len() - i;

        let mut result = String::new();
        result.push_str(&"U".repeat(up_moves));
        result.push_str(&dest_path[i..].iter().collect::<String>());

        result
    }

    fn dfs(node: &Option<Box<TreeNode>>, parent_map: &mut HashMap<i32, i32>) {
        if let Some(n) = node {
            if let Some(left) = &n.left {
                parent_map.insert(left.val, n.val);
                Self::dfs(&Some(left.clone()), parent_map);
            }
            if let Some(right) = &n.right {
                parent_map.insert(right.val, n.val);
                Self::dfs(&Some(right.clone()), parent_map);
            }
        }
    }

    fn find_node(node: &Option<Box<TreeNode>>, value: i32) -> Option<Box<TreeNode>> {
        if let Some(n) = node {
            if n.val == value {
                return Some(n.clone());
            }
            if let Some(left) = &n.left {
                if let Some(found) = Self::find_node(&Some(left.clone()), value) {
                    return Some(found);
                }
            }
            if let Some(right) = &n.right {
                if let Some(found) = Self::find_node(&Some(right.clone()), value) {
                    return Some(found);
                }
            }
        }
        None
    }

    fn find_path(parent_map: &HashMap<i32, i32>, mut node: Option<Box<TreeNode>>, path: &mut String) {
        let mut current_val = node.as_ref().unwrap().val;
        while let Some(&parent_val) = parent_map.get(&current_val) {
            path.push('U');
            current_val = parent_val;
        }
        path.reverse();
    }
}