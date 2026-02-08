use std::collections::HashMap;

pub struct TreeNode {
    pub val: i32,
    pub children: Vec<TreeNode>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            children: Vec::new(),
        }
    }
}

pub struct NestedInteger {
    pub value: Option<i32>,
    pub list: Option<Vec<NestedInteger>>,
}

impl NestedInteger {
    pub fn new() -> Self {
        NestedInteger {
            value: None,
            list: None,
        }
    }

    pub fn add(&mut self, ni: NestedInteger) {
        if self.list.is_none() {
            self.list = Some(Vec::new());
        }
        self.list.as_mut().unwrap().push(ni);
    }

    pub fn set_integer(&mut self, value: i32) {
        self.value = Some(value);
        self.list = None;
    }

    pub fn is_integer(&self) -> bool {
        self.value.is_some()
    }

    pub fn get_integer(&self) -> i32 {
        self.value.unwrap()
    }

    pub fn get_list(&self) -> Vec<NestedInteger> {
        self.list.clone().unwrap_or_else(Vec::new)
    }
}

pub fn nested_integer_to_tree(ni: NestedInteger) -> Option<Box<TreeNode>> {
    if ni.is_integer() {
        return Some(Box::new(TreeNode::new(ni.get_integer())));
    }

    let mut root = TreeNode::new(0);
    for child in ni.get_list() {
        if let Some(child_node) = nested_integer_to_tree(child) {
            root.children.push(*child_node);
        }
    }

    Some(Box::new(root))
}

pub fn tree_to_nested_integer(root: Option<Box<TreeNode>>) -> NestedInteger {
    if let Some(node) = root {
        if node.children.is_empty() {
            let mut ni = NestedInteger::new();
            ni.set_integer(node.val);
            ni
        } else {
            let mut ni = NestedInteger::new();
            for child in node.children {
                ni.add(tree_to_nested_integer(Some(child)));
            }
            ni
        }
    } else {
        NestedInteger::new()
    }
}