use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn btree_game_winning_move(root: Option<Rc<RefCell<TreeNode>>>, n: i32, x: i32) -> bool {
        fn count_nodes(node: &Option<Rc<RefCell<TreeNode>>>, x: i32, x_node: &mut Option<Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                Some(n) => {
                    let mut count = 1;
                    let left_count = count_nodes(&n.borrow().left, x, x_node);
                    let right_count = count_nodes(&n.borrow().right, x, x_node);
                    count += left_count + right_count;

                    if n.borrow().val == x {
                        *x_node = Some(n.clone());
                    }

                    count
                }
                None => 0,
            }
        }

        let mut x_node: Option<Rc<RefCell<TreeNode>>> = None;
        count_nodes(&root, x, &mut x_node);

        if let Some(x_n) = x_node {
            let left_count = count_nodes(&x_n.borrow().left, x, &mut None);
            let right_count = count_nodes(&x_n.borrow().right, x, &mut None);

            let parent_count = n - 1 - left_count - right_count;

            return left_count > (n / 2) || right_count > (n / 2) || parent_count > (n / 2);
        }

        false
    }
}