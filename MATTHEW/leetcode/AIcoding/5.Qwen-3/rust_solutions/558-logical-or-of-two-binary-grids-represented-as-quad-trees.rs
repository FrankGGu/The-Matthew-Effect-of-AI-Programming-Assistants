impl Solution {

#[derive(Clone, Copy, PartialEq, Eq)]
pub struct Node {
    pub val: bool,
    pub is_leaf: bool,
    pub topLeft: Option<Box<Node>>,
    pub topRight: Option<Box<Node>>,
    pub bottomLeft: Option<Box<Node>>,
    pub bottomRight: Option<Box<Node>>,
}

impl Node {
    pub fn new(val: bool, is_leaf: bool, topLeft: Option<Box<Node>>, topRight: Option<Box<Node>>, bottomLeft: Option<Box<Node>>, bottomRight: Option<Box<Node>>) -> Self {
        Node {
            val,
            is_leaf,
            topLeft,
            topRight,
            bottomLeft,
            bottomRight,
        }
    }
}

struct Solution {}

impl Solution {
    pub fn intersect(quadTree1: Option<Box<Node>>, quadTree2: Option<Box<Node>>) -> Option<Box<Node>> {
        if quadTree1.is_none() {
            return quadTree2;
        }
        if quadTree2.is_none() {
            return quadTree1;
        }

        let node1 = quadTree1.unwrap();
        let node2 = quadTree2.unwrap();

        if node1.is_leaf && node2.is_leaf {
            return Some(Box::new(Node::new(node1.val || node2.val, true, None, None, None, None)));
        }

        if node1.is_leaf {
            return if node1.val {
                Some(Box::new(Node::new(true, true, None, None, None, None)))
            } else {
                Some(Box::new(Node::new(node2.val, node2.is_leaf, node2.topLeft, node2.topRight, node2.bottomLeft, node2.bottomRight)))
            };
        }

        if node2.is_leaf {
            return if node2.val {
                Some(Box::new(Node::new(true, true, None, None, None, None)))
            } else {
                Some(Box::new(Node::new(node1.val, node1.is_leaf, node1.topLeft, node1.topRight, node1.bottomLeft, node1.bottomRight)))
            };
        }

        let topLeft = Self::intersect(node1.topLeft, node2.topLeft);
        let topRight = Self::intersect(node1.topRight, node2.topRight);
        let bottomLeft = Self::intersect(node1.bottomLeft, node2.bottomLeft);
        let bottomRight = Self::intersect(node1.bottomRight, node2.bottomRight);

        if topLeft.is_some()
            && topRight.is_some()
            && bottomLeft.is_some()
            && bottomRight.is_some()
            && topLeft.as_ref().unwrap().is_leaf
            && topRight.as_ref().unwrap().is_leaf
            && bottomLeft.as_ref().unwrap().is_leaf
            && bottomRight.as_ref().unwrap().is_leaf
            && topLeft.as_ref().unwrap().val == topRight.as_ref().unwrap().val
            && topLeft.as_ref().unwrap().val == bottomLeft.as_ref().unwrap().val
            && topLeft.as_ref().unwrap().val == bottomRight.as_ref().unwrap().val
        {
            return Some(Box::new(Node::new(topLeft.as_ref().unwrap().val, true, None, None, None, None)));
        }

        Some(Box::new(Node::new(false, false, topLeft, topRight, bottomLeft, bottomRight)))
    }
}
}