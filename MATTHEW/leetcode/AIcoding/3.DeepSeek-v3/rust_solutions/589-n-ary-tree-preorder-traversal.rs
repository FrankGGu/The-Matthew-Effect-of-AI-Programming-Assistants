#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Node>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

impl Solution {
    pub fn preorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if let Some(node) = root {
            let node = node.borrow();
            result.push(node.val);
            for child in &node.children {
                result.extend(Solution::preorder(Some(Rc::clone(child))));
            }
        }
        result
    }
}