use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;

type TreeNode = Option<Rc<RefCell<TreeNodeInner>>>;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNodeInner {
    pub val: i32,
    pub left: TreeNode,
    pub right: TreeNode,
}

impl TreeNodeInner {
    #[inline]
    pub fn new(val: i32) -> TreeNode {
        Some(Rc::new(RefCell::new(TreeNodeInner {
            val,
            left: None,
            right: None,
        })))
    }
}

impl Solution {
    pub fn find_frequent_tree_sum(root: TreeNode) -> Vec<i32> {
        let mut sum_counts: HashMap<i32, i32> = HashMap::new();
        Solution::subtree_sum(root.clone(), &mut sum_counts);

        let mut max_count = 0;
        for &count in sum_counts.values() {
            max_count = max_count.max(count);
        }

        let mut result: Vec<i32> = Vec::new();
        for (&sum, &count) in &sum_counts {
            if count == max_count {
                result.push(sum);
            }
        }

        result
    }

    fn subtree_sum(node: TreeNode, sum_counts: &mut HashMap<i32, i32>) -> i32 {
        match node {
            Some(n) => {
                let left_sum = Solution::subtree_sum(n.borrow().left.clone(), sum_counts);
                let right_sum = Solution::subtree_sum(n.borrow().right.clone(), sum_counts);
                let current_sum = n.borrow().val + left_sum + right_sum;

                *sum_counts.entry(current_sum).or_insert(0) += 1;
                current_sum
            }
            None => 0,
        }
    }
}

struct Solution;