use std::collections::HashMap;

#[derive(Debug)]
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

pub fn create_binary_tree(descriptions: Vec<Vec<i32>>) -> Option<Box<TreeNode>> {
    let mut map: HashMap<i32, TreeNode> = HashMap::new();
    let mut has_parent = std::collections::HashSet::new();

    for desc in descriptions {
        let parent = desc[0];
        let child = desc[1];
        let is_left = desc[2] == 1;

        let parent_node = map.entry(parent).or_insert(TreeNode::new(parent));
        let child_node = map.entry(child).or_insert(TreeNode::new(child));

        if is_left {
            parent_node.left = Some(Box::new(child_node.clone()));
        } else {
            parent_node.right = Some(Box::new(child_node.clone()));
        }

        has_parent.insert(child);
    }

    for (key, node) in map.iter() {
        if !has_parent.contains(key) {
            return Some(Box::new(node.clone()));
        }
    }

    None
}