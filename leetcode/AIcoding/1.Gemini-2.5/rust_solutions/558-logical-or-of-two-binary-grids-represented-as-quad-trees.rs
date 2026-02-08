use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
  pub val: bool,
  pub is_leaf: bool,
  pub top_left: Option<Rc<Node>>,
  pub top_right: Option<Rc<Node>>,
  pub bottom_left: Option<Rc<Node>>,
  pub bottom_right: Option<Rc<Node>>,
}

impl Node {
  #[inline]
  pub fn new(val: bool, is_leaf: bool, top_left: Option<Rc<Node>>, top_right: Option<Rc<Node>>, bottom_left: Option<Rc<Node>>, bottom_right: Option<Rc<Node>>) -> Self {
    Node {
      val,
      is_leaf,
      top_left,
      top_right,
      bottom_left,
      bottom_right
    }
  }
}

struct Solution;

impl Solution {
    pub fn intersect(quad1: Option<Rc<Node>>, quad2: Option<Rc<Node>>) -> Option<Rc<Node>> {
        match (quad1, quad2) {
            (None, None) => None,
            (Some(n1), None) => Some(n1),
            (None, Some(n2)) => Some(n2),
            (Some(n1), Some(n2)) => {
                // Case 1: n1 is a leaf
                if n1.is_leaf {
                    if n1.val { // n1 is all 1s
                        // ORing with all 1s results in all 1s
                        return Some(Rc::new(Node::new(true, true, None, None, None, None)));
                    } else { // n1 is all 0s
                        // ORing with all 0s results in n2
                        return Some(n2);
                    }
                }

                // Case 2: n2 is a leaf
                if n2.is_leaf {
                    if n2.val { // n2 is all 1s
                        // ORing with all 1s results in all 1s
                        return Some(Rc::new(Node::new(true, true, None, None, None, None)));
                    } else { // n2 is all 0s
                        // ORing with all 0s results in n1
                        return Some(n1);
                    }
                }

                // Case 3: Neither n1 nor n2 is a leaf (both are internal nodes)
                let top_left = Solution::intersect(n1.top_left.clone(), n2.top_left.clone());
                let top_right = Solution::intersect(n1.top_right.clone(), n2.top_right.clone());
                let bottom_left = Solution::intersect(n1.bottom_left.clone(), n2.bottom_left.clone());
                let bottom_right = Solution::intersect(n1.bottom_right.clone(), n2.bottom_right.clone());

                // Check if the children can be merged into a leaf node
                if let (Some(tl), Some(tr), Some(bl), Some(br)) = (&top_left, &top_right, &bottom_left, &bottom_right) {
                    if tl.is_leaf && tr.is_leaf && bl.is_leaf && br.is_leaf &&
                       tl.val == tr.val && tl.val == bl.val && tl.val == br.val {
                        // All children are leaves and have the same value, so merge them
                        return Some(Rc::new(Node::new(tl.val, true, None, None, None, None)));
                    }
                }

                // Otherwise, create a new internal node
                Some(Rc::new(Node::new(false, false, top_left, top_right, bottom_left, bottom_right)))
            }
        }
    }
}