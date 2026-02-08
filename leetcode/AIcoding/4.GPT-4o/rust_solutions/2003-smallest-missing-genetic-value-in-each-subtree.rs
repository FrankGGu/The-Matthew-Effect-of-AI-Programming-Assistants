use std::collections::{HashSet, HashMap};

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn smallest_missing_value(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut result = vec![];
    let mut map: HashMap<i32, HashSet<i32>> = HashMap::new();

    fn dfs(node: &Option<Box<TreeNode>>, map: &mut HashMap<i32, HashSet<i32>>, parent: i32) {
        if let Some(n) = node {
            map.entry(parent).or_insert_with(HashSet::new).insert(n.val);
            dfs(&n.left, map, n.val);
            dfs(&n.right, map, n.val);
        }
    }

    dfs(&root, &mut map, 0);

    for &key in map.keys() {
        let mut seen = map[&key].clone();
        let mut smallest = 1;
        while seen.contains(&smallest) {
            smallest += 1;
        }
        result.push(smallest);
    }

    result
}