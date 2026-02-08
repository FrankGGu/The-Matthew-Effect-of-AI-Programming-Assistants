use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, VecDeque, HashSet};

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
      right: None
    }
  }
}

struct Solution;

impl Solution {
    pub fn distance_k(root: Option<Rc<RefCell<TreeNode>>>, target: Option<Rc<RefCell<TreeNode>>>, k: i32) -> Vec<i32> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();

        Self::build_graph_dfs(root.clone(), None, &mut graph);

        let target_val = target.unwrap().borrow().val;

        let mut queue: VecDeque<(i32, i32)> = VecDeque::new(); // (node_val, distance)
        let mut visited: HashSet<i32> = HashSet::new();
        let mut result: Vec<i32> = Vec::new();

        queue.push_back((target_val, 0));
        visited.insert(target_val);

        while let Some((curr_val, curr_dist)) = queue.pop_front() {
            if curr_dist == k {
                result.push(curr_val);
            } else if curr_dist < k {
                if let Some(neighbors) = graph.get(&curr_val) {
                    for &neighbor_val in neighbors {
                        if !visited.contains(&neighbor_val) {
                            visited.insert(neighbor_val);
                            queue.push_back((neighbor_val, curr_dist + 1));
                        }
                    }
                }
            } else { // curr_dist > k
                break; 
            }
        }

        result
    }

    fn build_graph_dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        parent_val: Option<i32>,
        graph: &mut HashMap<i32, Vec<i32>>,
    ) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let val = n.val;

            graph.entry(val).or_insert_with(Vec::new);

            if let Some(p_val) = parent_val {
                graph.entry(val).or_insert_with(Vec::new).push(p_val);
                graph.entry(p_val).or_insert_with(Vec::new).push(val);
            }

            Self::build_graph_dfs(n.left.clone(), Some(val), graph);
            Self::build_graph_dfs(n.right.clone(), Some(val), graph);
        }
    }
}