use std::rc::Rc;
use std::cell::RefCell;

type TreeNodeRef = Rc<RefCell<TreeNode>>;

impl Solution {
    pub fn generate_trees(n: i32) -> Vec<Option<TreeNodeRef>> {
        if n == 0 {
            return vec![];
        }
        Self::generate(1, n)
    }

    fn generate(start: i32, end: i32) -> Vec<Option<TreeNodeRef>> {
        let mut trees = vec![];
        if start > end {
            trees.push(None);
            return trees;
        }

        for i in start..=end {
            let left_trees = Self::generate(start, i - 1);
            let right_trees = Self::generate(i + 1, end);

            for left in &left_trees {
                for right in &right_trees {
                    let root = Rc::new(RefCell::new(TreeNode::new(i)));
                    root.borrow_mut().left = left.clone();
                    root.borrow_mut().right = right.clone();
                    trees.push(Some(root));
                }
            }
        }
        trees
    }
}