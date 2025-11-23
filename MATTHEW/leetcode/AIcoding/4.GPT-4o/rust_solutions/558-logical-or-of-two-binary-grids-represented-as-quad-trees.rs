#[derive(Clone, Copy)]
struct Node {
    val: bool,
    is_leaf: bool,
}

pub fn intersect(quadrant1: Option<Box<Node>>, quadrant2: Option<Box<Node>>) -> Option<Box<Node>> {
    match (quadrant1, quadrant2) {
        (None, None) => None,
        (Some(node), None) | (None, Some(node)) => Some(node),
        (Some(node1), Some(node2)) => {
            if node1.is_leaf {
                if node1.val {
                    return Some(node1);
                }
                return Some(node2);
            }
            if node2.is_leaf {
                if node2.val {
                    return Some(node2);
                }
                return Some(node1);
            }
            let top_left = intersect(node1.top_left, node2.top_left);
            let top_right = intersect(node1.top_right, node2.top_right);
            let bottom_left = intersect(node1.bottom_left, node2.bottom_left);
            let bottom_right = intersect(node1.bottom_right, node2.bottom_right);
            Some(Box::new(Node {
                val: top_left.as_ref().map_or(false, |n| n.val) || top_right.as_ref().map_or(false, |n| n.val) || bottom_left.as_ref().map_or(false, |n| n.val) || bottom_right.as_ref().map_or(false, |n| n.val),
                is_leaf: top_left.as_ref().map_or(false, |n| n.is_leaf) && top_right.as_ref().map_or(false, |n| n.is_leaf) && bottom_left.as_ref().map_or(false, |n| n.is_leaf) && bottom_right.as_ref().map_or(false, |n| n.is_leaf) && (top_left.as_ref().map_or(false, |n| n.val) == top_right.as_ref().map_or(false, |n| n.val)) && (top_left.as_ref().map_or(false, |n| n.val) == bottom_left.as_ref().map_or(false, |n| n.val)) && (top_left.as_ref().map_or(false, |n| n.val) == bottom_right.as_ref().map_or(false, |n| n.val)),
            }))
        }
    }
}