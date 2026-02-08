use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn print_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<String>> {
        if root.is_none() {
            return vec![];
        }
        let root = root.unwrap();
        let height = Self::get_height(&root);
        let m = height + 1;
        let n = (1 << (height + 1)) - 1;
        let mut res = vec![vec!["".to_string(); n as usize]; m as usize];
        let mut queue = VecDeque::new();
        queue.push_back((root, 0, (n - 1) / 2));
        while let Some((node, r, c)) = queue.pop_front() {
            let node = node.borrow();
            res[r as usize][c as usize] = node.val.to_string();
            if node.left.is_some() {
                queue.push_back((node.left.as_ref().unwrap().clone(), r + 1, c - (1 << (height - r - 1))));
            }
            if node.right.is_some() {
                queue.push_back((node.right.as_ref().unwrap().clone(), r + 1, c + (1 << (height - r - 1))));
            }
        }
        res
    }

    fn get_height(root: &Rc<RefCell<TreeNode>>) -> i32 {
        let mut height = 0;
        let mut queue = VecDeque::new();
        queue.push_back(root.clone());
        while !queue.is_empty() {
            let len = queue.len();
            for _ in 0..len {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                if node.left.is_some() {
                    queue.push_back(node.left.as_ref().unwrap().clone());
                }
                if node.right.is_some() {
                    queue.push_back(node.right.as_ref().unwrap().clone());
                }
            }
            if !queue.is_empty() {
                height += 1;
            }
        }
        height
    }
}