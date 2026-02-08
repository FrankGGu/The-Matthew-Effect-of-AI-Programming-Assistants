use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn tree_queries(root: Option<Rc<RefCell<TreeNode>>>, queries: Vec<i32>) -> Vec<i32> {
        let mut depth = HashMap::new();
        let mut height = HashMap::new();
        let mut nodes = HashMap::new();

        Self::dfs(&root, 0, &mut depth, &mut height, &mut nodes);

        let mut top1 = vec![-1; nodes.len() + 1];
        let mut top2 = vec![-1; nodes.len() + 1];

        for (_, &node_val) in nodes.iter() {
            let parent = nodes[&node_val];
            let h = height[&node_val];

            if h > top1[parent as usize] {
                top2[parent as usize] = top1[parent as usize];
                top1[parent as usize] = h;
            } else if h > top2[parent as usize] {
                top2[parent as usize] = h;
            }
        }

        let mut res = vec![0; queries.len()];
        for (i, &q) in queries.iter().enumerate() {
            let node = nodes[&q];
            let parent = nodes[&node];
            let max_h = if height[&q] == top1[parent as usize] {
                top2[parent as usize]
            } else {
                top1[parent as usize]
            };
            res[i] = depth[&node] + max_h;
        }

        res
    }

    fn dfs(
        node: &Option<Rc<RefCell<TreeNode>>>,
        d: i32,
        depth: &mut HashMap<i32, i32>,
        height: &mut HashMap<i32, i32>,
        nodes: &mut HashMap<i32, i32>,
    ) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let val = n.val;
            depth.insert(val, d);
            nodes.insert(val, if d == 0 { -1 } else { nodes[&val] });
            let left_h = Self::dfs(&n.left, d + 1, depth, height, nodes);
            let right_h = Self::dfs(&n.right, d + 1, depth, height, nodes);
            let h = left_h.max(right_h) + 1;
            height.insert(val, h);
            h
        } else {
            -1
        }
    }
}