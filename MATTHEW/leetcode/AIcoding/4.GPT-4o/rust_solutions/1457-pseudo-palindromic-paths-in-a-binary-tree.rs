use std::collections::HashMap;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn pseudo_palindromic_paths(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: Option<&Box<TreeNode>>, count: &mut HashMap<i32, i32>) -> i32 {
            if node.is_none() {
                return 0;
            }
            let node = node.unwrap();
            let val = node.val;
            *count.entry(val).or_insert(0) += 1;

            let mut paths = 0;
            if node.left.is_none() && node.right.is_none() {
                let odd_count = count.values().filter(|&&v| v % 2 == 1).count();
                if odd_count <= 1 {
                    paths += 1;
                }
            } else {
                paths += dfs(node.left.as_ref(), count);
                paths += dfs(node.right.as_ref(), count);
            }

            *count.get_mut(&val).unwrap() -= 1;
            if *count.get(&val).unwrap() == 0 {
                count.remove(&val);
            }

            paths
        }

        let mut count = HashMap::new();
        dfs(root.as_ref(), &mut count)
    }
}