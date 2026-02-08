use std::collections::{HashMap, HashSet, VecDeque};

#[derive(TreeNode)]
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
    pub fn distance_k(root: Option<Box<TreeNode>>, target: i32, k: i32) -> Vec<i32> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        Self::build_graph(&root, &mut graph);

        let mut result = Vec::new();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((target, 0));
        visited.insert(target);

        while let Some((node, dist)) = queue.pop_front() {
            if dist == k {
                result.push(node);
            }
            if dist < k {
                for &neighbor in graph.get(&node).unwrap_or(&Vec::new()) {
                    if visited.insert(neighbor) {
                        queue.push_back((neighbor, dist + 1));
                    }
                }
            }
        }

        result
    }

    fn build_graph(node: &Option<Box<TreeNode>>, graph: &mut HashMap<i32, Vec<i32>>) {
        if let Some(n) = node {
            let val = n.val;
            if let Some(left) = &n.left {
                graph.entry(val).or_default().push(left.val);
                graph.entry(left.val).or_default().push(val);
                Self::build_graph(&n.left, graph);
            }
            if let Some(right) = &n.right {
                graph.entry(val).or_default().push(right.val);
                graph.entry(right.val).or_default().push(val);
                Self::build_graph(&n.right, graph);
            }
        }
    }
}