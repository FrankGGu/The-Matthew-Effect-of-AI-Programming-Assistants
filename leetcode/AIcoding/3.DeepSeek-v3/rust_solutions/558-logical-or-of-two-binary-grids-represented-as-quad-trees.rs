#[derive(Debug, PartialEq, Eq)]
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
    pub fn new(val: bool, is_leaf: bool) -> Self {
        Node {
            val,
            is_leaf,
            top_left: None,
            top_right: None,
            bottom_left: None,
            bottom_right: None,
        }
    }
}

impl Solution {
    pub fn intersect(quad_tree1: Option<Box<Node>>, quad_tree2: Option<Box<Node>>) -> Option<Box<Node>> {
        match (quad_tree1, quad_tree2) {
            (None, None) => None,
            (Some(q1), None) => Some(q1),
            (None, Some(q2)) => Some(q2),
            (Some(q1), Some(q2)) => {
                if q1.is_leaf && q2.is_leaf {
                    Some(Box::new(Node::new(q1.val || q2.val, true)))
                } else if q1.is_leaf {
                    if q1.val {
                        Some(Box::new(Node::new(true, true)))
                    } else {
                        Some(q2)
                    }
                } else if q2.is_leaf {
                    if q2.val {
                        Some(Box::new(Node::new(true, true)))
                    } else {
                        Some(q1)
                    }
                } else {
                    let tl = Self::intersect(q1.top_left, q2.top_left);
                    let tr = Self::intersect(q1.top_right, q2.top_right);
                    let bl = Self::intersect(q1.bottom_left, q2.bottom_left);
                    let br = Self::intersect(q1.bottom_right, q2.bottom_right);
                    if let (Some(tl_node), Some(tr_node), Some(bl_node), Some(br_node)) = (&tl, &tr, &bl, &br) {
                        if tl_node.is_leaf && tr_node.is_leaf && bl_node.is_leaf && br_node.is_leaf &&
                           tl_node.val == tr_node.val && tl_node.val == bl_node.val && tl_node.val == br_node.val {
                            return Some(Box::new(Node::new(tl_node.val, true)));
                        }
                    }
                    Some(Box::new(Node {
                        val: false,
                        is_leaf: false,
                        top_left: tl,
                        top_right: tr,
                        bottom_left: bl,
                        bottom_right: br,
                    }))
                }
            }
        }
    }
}