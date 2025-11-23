use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_number_of_nodes(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        fn build_tree(n: i32) -> Option<Rc<RefCell<TreeNode>>> {
            if n == 0 {
                return None;
            }
            let root = Rc::new(RefCell::new(TreeNode::new(n)));
            root.borrow_mut().left = build_tree(n - 1);
            root.borrow_mut().right = None;
            Some(root)
        }

        fn count_nodes(root: &Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32, color: i32) -> i32 {
            if let Some(node) = root {
                let val = node.borrow().val;
                let current_color = node.borrow().color;

                let mut count = 0;

                if val >= low && val <= high {
                    if current_color == color {
                        count += 1;
                    }
                }

                if val > low {
                    count += count_nodes(&node.borrow().left, low, high, color);
                }

                if val < high {
                    count += count_nodes(&node.borrow().right, low, high, color);
                }

                count
            } else {
                0
            }
        }

        fn update_color(root: &Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32, color: i32) {
            if let Some(node) = root {
                let val = node.borrow().val;

                if val >= low && val <= high {
                    node.borrow_mut().color = color;
                }

                if val > low {
                    update_color(&node.borrow().left, low, high, color);
                }

                if val < high {
                    update_color(&node.borrow().right, low, high, color);
                }
            }
        }

        #[derive(Debug, PartialEq, Eq)]
        pub struct TreeNode {
            pub val: i32,
            pub left: Option<Rc<RefCell<TreeNode>>>,
            pub right: Option<Rc<RefCell<TreeNode>>>,
            pub color: i32,
        }

        impl TreeNode {
            #[inline]
            pub fn new(val: i32) -> Self {
                TreeNode {
                    val,
                    left: None,
                    right: None,
                    color: 0,
                }
            }
        }

        let mut root = build_tree(n);
        let mut result = Vec::new();

        for query in queries {
            let op = query[0];
            let low = query[1];
            let high = query[2];

            if op == 0 {
                update_color(&root, low, high, query[3]);
            } else {
                result.push(count_nodes(&root, low, high, query[3]));
            }
        }

        result
    }
}