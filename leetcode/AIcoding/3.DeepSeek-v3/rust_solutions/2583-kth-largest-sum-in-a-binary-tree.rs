use std::rc::Rc;
use std::cell::RefCell;
use std::collections::BinaryHeap;

impl Solution {
    pub fn kth_largest_level_sum(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        let mut queue = std::collections::VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_sum = 0i64;

            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                level_sum += node.val as i64;

                if let Some(left) = &node.left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node.right {
                    queue.push_back(Rc::clone(right));
                }
            }

            heap.push(level_sum);
        }

        if heap.len() < k as usize {
            return -1;
        }

        let mut result = -1;
        for _ in 0..k {
            result = heap.pop().unwrap();
        }
        result
    }
}