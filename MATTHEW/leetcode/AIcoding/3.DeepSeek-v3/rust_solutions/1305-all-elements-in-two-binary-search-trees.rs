use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn get_all_elements(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut vec1 = Vec::new();
        let mut vec2 = Vec::new();
        Self::inorder_traversal(root1, &mut vec1);
        Self::inorder_traversal(root2, &mut vec2);
        let mut res = Vec::new();
        let mut i = 0;
        let mut j = 0;
        while i < vec1.len() && j < vec2.len() {
            if vec1[i] < vec2[j] {
                res.push(vec1[i]);
                i += 1;
            } else {
                res.push(vec2[j]);
                j += 1;
            }
        }
        while i < vec1.len() {
            res.push(vec1[i]);
            i += 1;
        }
        while j < vec2.len() {
            res.push(vec2[j]);
            j += 1;
        }
        res
    }

    fn inorder_traversal(root: Option<Rc<RefCell<TreeNode>>>, vec: &mut Vec<i32>) {
        if let Some(node) = root {
            let node = node.borrow();
            Self::inorder_traversal(node.left.clone(), vec);
            vec.push(node.val);
            Self::inorder_traversal(node.right.clone(), vec);
        }
    }
}