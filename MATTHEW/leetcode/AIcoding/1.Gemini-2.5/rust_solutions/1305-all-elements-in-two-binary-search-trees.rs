use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    fn inorder_traverse(node_opt: Option<Rc<RefCell<TreeNode>>>, elements: &mut Vec<i32>) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            Self::inorder_traverse(node.left.clone(), elements);
            elements.push(node.val);
            Self::inorder_traverse(node.right.clone(), elements);
        }
    }

    pub fn get_all_elements(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut list1 = Vec::new();
        Self::inorder_traverse(root1, &mut list1);

        let mut list2 = Vec::new();
        Self::inorder_traverse(root2, &mut list2);

        let mut result = Vec::with_capacity(list1.len() + list2.len());
        let mut p1 = 0;
        let mut p2 = 0;

        while p1 < list1.len() && p2 < list2.len() {
            if list1[p1] <= list2[p2] {
                result.push(list1[p1]);
                p1 += 1;
            } else {
                result.push(list2[p2]);
                p2 += 1;
            }
        }

        while p1 < list1.len() {
            result.push(list1[p1]);
            p1 += 1;
        }

        while p2 < list2.len() {
            result.push(list2[p2]);
            p2 += 1;
        }

        result
    }
}