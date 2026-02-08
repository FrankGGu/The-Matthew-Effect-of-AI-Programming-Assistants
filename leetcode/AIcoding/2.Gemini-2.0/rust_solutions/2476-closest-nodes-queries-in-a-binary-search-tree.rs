use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn closest_nodes(
        root: Option<Rc<RefCell<TreeNode>>>,
        queries: Vec<i32>,
    ) -> Vec<Vec<i32>> {
        let mut sorted_nodes = Vec::new();
        fn inorder(node: Option<Rc<RefCell<TreeNode>>>, sorted_nodes: &mut Vec<i32>) {
            if let Some(node_ref) = node {
                inorder(node_ref.borrow().left.clone(), sorted_nodes);
                sorted_nodes.push(node_ref.borrow().val);
                inorder(node_ref.borrow().right.clone(), sorted_nodes);
            }
        }
        inorder(root, &mut sorted_nodes);

        let mut result = Vec::new();
        for &query in &queries {
            let mut lower = -1;
            let mut upper = -1;

            let lower_bound = match sorted_nodes.binary_search(&query) {
                Ok(index) => {
                    lower = query;
                    index
                }
                Err(index) => {
                    if index > 0 {
                        lower = sorted_nodes[index - 1];
                    }
                    index
                }
            };

            let upper_bound = match sorted_nodes.binary_search(&query) {
                Ok(index) => {
                    upper = query;
                    index
                }
                Err(index) => {
                    if index < sorted_nodes.len() {
                        upper = sorted_nodes[index];
                    }
                    index
                }
            };

            if lower_bound > 0 {
                if sorted_nodes[lower_bound - 1] <= query {
                    lower = sorted_nodes[lower_bound - 1];
                } else {
                   lower = -1; 
                }
            } else {
                if sorted_nodes.len() > 0 && sorted_nodes[0] < query {
                    lower = sorted_nodes[0];
                } else {
                    lower = -1;
                }
            }

            if upper_bound < sorted_nodes.len() {
                if sorted_nodes[upper_bound] >= query {
                    upper = sorted_nodes[upper_bound];
                } else {
                    upper = -1;
                }
            } else {
                upper = -1;
            }

            if lower_bound == 0 && sorted_nodes.len() > 0 && sorted_nodes[0] > query {
                lower = -1;
            }

            if sorted_nodes.len() == 0 {
                lower = -1;
                upper = -1;
            } else if sorted_nodes[sorted_nodes.len() - 1] < query {
                upper = -1;
            }

            if sorted_nodes.contains(&query) {
                lower = query;
                upper = query;
            } else {
                if lower_bound < sorted_nodes.len() && sorted_nodes[lower_bound] < query {
                   lower = sorted_nodes[lower_bound];
                }
                if upper_bound > 0 && sorted_nodes[upper_bound - 1] > query {
                    upper = sorted_nodes[upper_bound - 1];
                }
            }

            let mut l_tmp = -1;
            for i in (0..sorted_nodes.len()).rev() {
                if sorted_nodes[i] <= query {
                    l_tmp = sorted_nodes[i];
                    break;
                }
            }

            if l_tmp != -1 {
                lower = l_tmp;
            }

            let mut u_tmp = -1;
            for i in 0..sorted_nodes.len() {
                if sorted_nodes[i] >= query {
                    u_tmp = sorted_nodes[i];
                    break;
                }
            }

            if u_tmp != -1 {
                upper = u_tmp;
            }

            result.push(vec![lower, upper]);
        }

        result
    }
}