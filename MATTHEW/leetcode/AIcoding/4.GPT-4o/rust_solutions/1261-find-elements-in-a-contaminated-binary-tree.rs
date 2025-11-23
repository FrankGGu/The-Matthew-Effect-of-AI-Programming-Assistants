use std::collections::HashSet;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

struct FindElements {
    values: HashSet<i32>,
}

impl FindElements {
    fn new(root: Option<Box<TreeNode>>) -> Self {
        let mut values = HashSet::new();
        Self::recover_tree(&root, 0, &mut values);
        FindElements { values }
    }

    fn recover_tree(node: &Option<Box<TreeNode>>, val: i32, values: &mut HashSet<i32>) {
        if let Some(n) = node {
            values.insert(val);
            Self::recover_tree(&n.left, 2 * val + 1, values);
            Self::recover_tree(&n.right, 2 * val + 2, values);
        }
    }

    fn find(&self, target: i32) -> bool {
        self.values.contains(&target)
    }
}