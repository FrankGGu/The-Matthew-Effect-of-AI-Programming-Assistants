use std::collections::{HashMap, HashSet, VecDeque};

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn amount_of_time(root: Option<Box<TreeNode>>, start: i32) -> i32 {
        let mut graph = HashMap::new();
        Self::build_graph(&root, &mut graph);

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        queue.push_back((start, 0));
        visited.insert(start);
        let mut max_time = 0;

        while let Some((node, time)) = queue.pop_front() {
            max_time = max_time.max(time);
            for &neighbor in graph.get(&node).unwrap_or(&vec![]) {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back((neighbor, time + 1));
                }
            }
        }

        max_time
    }

    fn build_graph(node: &Option<Box<TreeNode>>, graph: &mut HashMap<i32, Vec<i32>>) {
        if let Some(n) = node {
            let val = n.val;
            if let Some(ref left) = n.left {
                graph.entry(val).or_default().push(left.val);
                graph.entry(left.val).or_default().push(val);
                Self::build_graph(&Some(left.clone()), graph);
            }
            if let Some(ref right) = n.right {
                graph.entry(val).or_default().push(right.val);
                graph.entry(right.val).or_default().push(val);
                Self::build_graph(&Some(right.clone()), graph);
            }
        }
    }
}