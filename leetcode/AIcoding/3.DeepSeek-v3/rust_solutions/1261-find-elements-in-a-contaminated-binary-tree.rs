use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

struct FindElements {
    values: HashSet<i32>,
}

impl FindElements {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut values = HashSet::new();
        if let Some(root) = root {
            let mut stack = vec![(root, 0)];
            while let Some((node, val)) = stack.pop() {
                let mut node = node.borrow_mut();
                node.val = val;
                values.insert(val);
                if let Some(left) = node.left.take() {
                    stack.push((left, 2 * val + 1));
                }
                if let Some(right) = node.right.take() {
                    stack.push((right, 2 * val + 2));
                }
            }
        }
        FindElements { values }
    }

    fn find(&self, target: i32) -> bool {
        self.values.contains(&target)
    }
}