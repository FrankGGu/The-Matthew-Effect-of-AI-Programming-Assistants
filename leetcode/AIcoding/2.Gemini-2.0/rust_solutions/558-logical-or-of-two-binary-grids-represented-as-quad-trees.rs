#[derive(PartialEq, Eq, Clone, Debug)]
pub struct Node {
    pub val: bool,
    pub is_leaf: bool,
    pub top_left: Option<Box<Node>>,
    pub top_right: Option<Box<Node>>,
    pub bottom_left: Option<Box<Node>>,
    pub bottom_right: Option<Box<Node>>,
}

impl Node {
    #[inline]
    pub fn new(
        val: bool,
        is_leaf: bool,
        top_left: Option<Box<Node>>,
        top_right: Option<Box<Node>>,
        bottom_left: Option<Box<Node>>,
        bottom_right: Option<Box<Node>>,
    ) -> Self {
        Node {
            val,
            is_leaf,
            top_left,
            top_right,
            bottom_left,
            bottom_right,
        }
    }
}

impl Solution {
    pub fn intersect(
        quad_tree1: Option<Box<Node>>,
        quad_tree2: Option<Box<Node>>,
    ) -> Option<Box<Node>> {
        match (quad_tree1, quad_tree2) {
            (None, None) => None,
            (Some(node1), None) => Some(node1),
            (None, Some(node2)) => Some(node2),
            (Some(node1), Some(node2)) => {
                if node1.is_leaf {
                    if node1.val {
                        return Some(node1);
                    } else {
                        return Some(node2);
                    }
                }
                if node2.is_leaf {
                    if node2.val {
                        return Some(node2);
                    } else {
                        return Some(node1);
                    }
                }

                let top_left = Self::intersect(node1.top_left, node2.top_left);
                let top_right = Self::intersect(node1.top_right, node2.top_right);
                let bottom_left = Self::intersect(node1.bottom_left, node2.bottom_left);
                let bottom_right = Self::intersect(node1.bottom_right, node2.bottom_right);

                if top_left.as_ref().unwrap().is_leaf
                    && top_right.as_ref().unwrap().is_leaf
                    && bottom_left.as_ref().unwrap().is_leaf
                    && bottom_right.as_ref().unwrap().is_leaf
                    && top_left.as_ref().unwrap().val == top_right.as_ref().unwrap().val
                    && top_left.as_ref().unwrap().val == bottom_left.as_ref().unwrap().val
                    && top_left.as_ref().unwrap().val == bottom_right.as_ref().unwrap().val
                {
                    return Some(Box::new(Node::new(
                        top_left.as_ref().unwrap().val,
                        true,
                        None,
                        None,
                        None,
                        None,
                    )));
                }

                Some(Box::new(Node::new(
                    false,
                    false,
                    top_left,
                    top_right,
                    bottom_left,
                    bottom_right,
                )))
            }
        }
    }
}

struct Solution;