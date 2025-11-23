use std::collections::HashMap;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn find_mode(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut count = HashMap::new();
    let mut max_count = 0;

    fn inorder(node: &Option<Box<TreeNode>>, count: &mut HashMap<i32, i32>, max_count: &mut i32) {
        if let Some(n) = node {
            inorder(&n.left, count, max_count);
            let entry = count.entry(n.val).or_insert(0);
            *entry += 1;
            *max_count = (*max_count).max(*entry);
            inorder(&n.right, count, max_count);
        }
    }

    inorder(&root, &mut count, &mut max_count);
    count.into_iter().filter_map(|(k, v)| if v == max_count { Some(k) } else { None }).collect()
}