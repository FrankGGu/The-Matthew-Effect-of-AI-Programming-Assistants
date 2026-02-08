use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn recover_from_preorder(s: String) -> Option<Rc<RefCell<TreeNode>>> {
    let mut stack: Vec<(Option<Rc<RefCell<TreeNode>>>, usize)> = vec![];
    let mut i = 0;

    while i < s.len() {
        let mut level = 0;
        while i < s.len() && s.chars().nth(i).unwrap() == '-' {
            level += 1;
            i += 1;
        }

        let mut num = 0;
        while i < s.len() && s.chars().nth(i).unwrap().is_digit(10) {
            num = num * 10 + (s.chars().nth(i).unwrap() as i32 - '0' as i32);
            i += 1;
        }

        let node = Rc::new(RefCell::new(TreeNode::new(num)));

        while stack.len() > level {
            stack.pop();
        }

        if let Some((parent, _)) = stack.last_mut() {
            if parent.as_ref().unwrap().borrow().left.is_none() {
                parent.as_ref().unwrap().borrow_mut().left = Some(node.clone());
            } else {
                parent.as_ref().unwrap().borrow_mut().right = Some(node.clone());
            }
        }

        stack.push((Some(node.clone()), level));
    }

    stack.into_iter().next().map(|(node, _)| node).unwrap()
}