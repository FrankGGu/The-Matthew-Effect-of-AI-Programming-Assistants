use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn find_mode(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        Self::traverse(root.as_ref(), &mut freq, &mut max_freq);
        freq.into_iter()
            .filter(|&(_, count)| count == max_freq)
            .map(|(val, _)| val)
            .collect()
    }

    fn traverse(node: Option<&Rc<RefCell<TreeNode>>>, freq: &mut HashMap<i32, i32>, max_freq: &mut i32) {
        if let Some(n) = node {
            let node = n.borrow();
            let count = freq.entry(node.val).or_insert(0);
            *count += 1;
            *max_freq = (*max_freq).max(*count);
            Self::traverse(node.left.as_ref(), freq, max_freq);
            Self::traverse(node.right.as_ref(), freq, max_freq);
        }
    }
}