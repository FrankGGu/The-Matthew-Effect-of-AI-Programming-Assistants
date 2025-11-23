use std::collections::VecDeque;

impl Solution {
    pub fn tree_queries(root: Option<Rc<RefCell<TreeNode>>>, queries: Vec<i32>) -> Vec<i32> {
        use std::rc::Rc;
        use std::cell::RefCell;

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

        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, depth: i32, depth_map: &mut Vec<i32>, height_map: &mut Vec<i32>) -> i32 {
            if let Some(n) = node {
                let n = n.borrow();
                depth_map[n.val as usize] = depth;
                let left_height = dfs(&n.left, depth + 1, depth_map, height_map);
                let right_height = dfs(&n.right, depth + 1, depth_map, height_map);
                height_map[n.val as usize] = 1 + std::cmp::max(left_height, right_height);
                return height_map[n.val as usize];
            }
            -1
        }

        fn bfs(root: &Option<Rc<RefCell<TreeNode>>>, depth_map: &Vec<i32>, height_map: &Vec<i32>, up_height: i32, ans: &mut Vec<i32>) {
            let mut queue = VecDeque::new();
            if let Some(r) = root {
                queue.push_back((Rc::clone(r), up_height));
            }

            while let Some((node, up_height)) = queue.pop_front() {
                let val = node.borrow().val as usize;
                ans[val] = up_height;

                let mut left_height = -1;
                if let Some(left) = &node.borrow().left {
                    left_height = height_map[left.borrow().val as usize];
                }
                let mut right_height = -1;
                if let Some(right) = &node.borrow().right {
                    right_height = height_map[right.borrow().val as usize];
                }

                if let Some(left) = &node.borrow().left {
                    let new_up_height = 1 + std::cmp::max(up_height, right_height);
                    queue.push_back((Rc::clone(left), new_up_height));
                }
                if let Some(right) = &node.borrow().right {
                    let new_up_height = 1 + std::cmp::max(up_height, left_height);
                    queue.push_back((Rc::clone(right), new_up_height));
                }
            }
        }

        if root.is_none() {
            return vec![];
        }

        let mut depth_map = vec![0; 100001];
        let mut height_map = vec![0; 100001];
        dfs(&root, 0, &mut depth_map, &mut height_map);

        let mut ans = vec![0; 100001];
        bfs(&root, &depth_map, &height_map, -1, &mut ans);

        queries.iter().map(|&q| ans[q as usize]).collect()
    }
}