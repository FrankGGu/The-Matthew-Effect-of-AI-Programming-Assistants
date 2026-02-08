use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn get_all_elements(
        root1: Option<Rc<RefCell<TreeNode>>>,
        root2: Option<Rc<RefCell<TreeNode>>>,
    ) -> Vec<i32> {
        let mut nums1 = Vec::new();
        let mut nums2 = Vec::new();

        fn inorder(node: Option<Rc<RefCell<TreeNode>>>, nums: &mut Vec<i32>) {
            if let Some(n) = node {
                inorder(n.borrow().left.clone(), nums);
                nums.push(n.borrow().val);
                inorder(n.borrow().right.clone(), nums);
            }
        }

        inorder(root1, &mut nums1);
        inorder(root2, &mut nums2);

        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < nums1.len() && j < nums2.len() {
            if nums1[i] < nums2[j] {
                result.push(nums1[i]);
                i += 1;
            } else {
                result.push(nums2[j]);
                j += 1;
            }
        }

        while i < nums1.len() {
            result.push(nums1[i]);
            i += 1;
        }

        while j < nums2.len() {
            result.push(nums2[j]);
            j += 1;
        }

        result
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;