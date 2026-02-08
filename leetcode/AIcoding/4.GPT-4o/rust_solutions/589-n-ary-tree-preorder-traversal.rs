#[derive(Debug, Clone)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Node>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

pub fn preorder(root: Option<Box<Node>>) -> Vec<i32> {
    let mut result = Vec::new();
    fn traverse(node: Option<&Box<Node>>, result: &mut Vec<i32>) {
        if let Some(n) = node {
            result.push(n.val);
            for child in &n.children {
                traverse(Some(child), result);
            }
        }
    }
    traverse(root.as_ref(), &mut result);
    result
}