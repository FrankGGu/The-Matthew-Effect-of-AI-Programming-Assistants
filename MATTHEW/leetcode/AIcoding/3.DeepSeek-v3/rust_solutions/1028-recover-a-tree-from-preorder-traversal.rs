use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn recover_from_preorder(s: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut stack: Vec<(Rc<RefCell<TreeNode>>, usize)> = Vec::new();
        let mut i = 0;
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        while i < n {
            let mut depth = 0;
            while i < n && chars[i] == '-' {
                depth += 1;
                i += 1;
            }

            let mut val = 0;
            while i < n && chars[i].is_digit(10) {
                val = val * 10 + chars[i].to_digit(10).unwrap() as i32;
                i += 1;
            }

            let node = Rc::new(RefCell::new(TreeNode::new(val)));

            while stack.len() > depth {
                stack.pop();
            }

            if let Some(&(ref parent, _)) = stack.last() {
                if parent.borrow().left.is_none() {
                    parent.borrow_mut().left = Some(node.clone());
                } else {
                    parent.borrow_mut().right = Some(node.clone());
                }
            }

            stack.push((node, depth));
        }

        stack.first().map(|(node, _)| node.clone())
    }
}