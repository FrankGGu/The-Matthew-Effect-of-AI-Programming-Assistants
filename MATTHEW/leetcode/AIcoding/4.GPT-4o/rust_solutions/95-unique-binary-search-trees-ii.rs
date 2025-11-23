use crate::util::TreeNode;

pub fn generate_trees(n: i32) -> Vec<Option<Box<TreeNode>>> {
    if n == 0 {
        return vec![];
    }
    generate_trees_helper(1, n)
}

fn generate_trees_helper(start: i32, end: i32) -> Vec<Option<Box<TreeNode>>> {
    if start > end {
        return vec![None];
    }
    let mut all_trees = Vec::new();
    for i in start..=end {
        let left_trees = generate_trees_helper(start, i - 1);
        let right_trees = generate_trees_helper(i + 1, end);

        for left in left_trees.iter() {
            for right in right_trees.iter() {
                let root = Some(Box::new(TreeNode::new(i)));
                let mut new_tree = root.clone();
                if let Some(ref mut node) = new_tree {
                    node.left = left.clone();
                    node.right = right.clone();
                }
                all_trees.push(new_tree);
            }
        }
    }
    all_trees
}