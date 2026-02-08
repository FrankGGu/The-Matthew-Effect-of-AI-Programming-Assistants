impl Solution {
    pub fn average_of_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<f64> {
        let mut result: Vec<f64> = Vec::new();
        let mut queue: Vec<Rc<RefCell<TreeNode>>> = Vec::new();

        if let Some(node) = root {
            queue.push(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_sum: f64 = 0.0;
            let mut level_count: i32 = 0;

            for _ in 0..level_size {
                if let Some(node) = queue.remove(0).clone().take() {
                    let borrowed_node = node.borrow();
                    level_sum += borrowed_node.val as f64;
                    level_count += 1;

                    if let Some(left) = borrowed_node.left.clone() {
                        queue.push(left);
                    }

                    if let Some(right) = borrowed_node.right.clone() {
                        queue.push(right);
                    }
                }
            }

            result.push(level_sum / level_count as f64);
        }

        result
    }
}