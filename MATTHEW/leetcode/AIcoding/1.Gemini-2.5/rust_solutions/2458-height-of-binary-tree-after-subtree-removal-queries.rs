use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

struct Solution;

impl Solution {
    fn dfs1(
        node: Option<Rc<RefCell<TreeNode>>>,
        current_depth: i32,
        node_info: &mut HashMap<i32, (i32, i32, i32)>,
    ) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            let left_h = Self::dfs1(n.left.clone(), current_depth + 1, node_info);
            let right_h = Self::dfs1(n.right.clone(), current_depth + 1, node_info);

            node_info.insert(n.val, (current_depth, left_h, right_h));

            std::cmp::max(left_h, right_h) + 1
        } else {
            -1
        }
    }

    fn dfs2(
        node: Option<Rc<RefCell<TreeNode>>>,
        current_depth: i32,
        max_height_from_parent_side: i32,
        node_info: &HashMap<i32, (i32, i32, i32)>,
        ans_map: &mut HashMap<i32, i32>,
    ) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            ans_map.insert(n.val, max_height_from_parent_side);

            let (_, left_h, right_h) = *node_info.get(&n.val).unwrap();

            let left_child_max_height_from_parent_side =
                std::cmp::max(max_height_from_parent_side, current_depth + right_h + 1);

            let right_child_max_height_from_parent_side =
                std::cmp::max(max_height_from_parent_side, current_depth + left_h + 1);

            Self::dfs2(
                n.left.clone(),
                current_depth + 1,
                left_child_max_height_from_parent_side,
                node_info,
                ans_map,
            );

            Self::dfs2(
                n.right.clone(),
                current_depth + 1,
                right_child_max_height_from_parent_side,
                node_info,
                ans_map,
            );
        }
    }

    pub fn height_of_binary_tree_after_subtree_removal_queries(
        root: Option<Rc<RefCell<TreeNode>>>,
        queries: Vec<i32>,
    ) -> Vec<i32> {
        let mut node_info: HashMap<i32, (i32, i32, i32)> = HashMap::new();
        let mut ans_map: HashMap<i32, i32> = HashMap::new();

        Self::dfs1(root.clone(), 0, &mut node_info);

        Self::dfs2(root.clone(), 0, -1, &node_info, &mut ans_map);

        queries.into_iter().map(|q_val| *ans_map.get(&q_val).unwrap()).collect()
    }
}