pub fn find_closest_value_in_bst(root: Option<Box<TreeNode>>, target: f64) -> i32 {
    let mut closest = i32::MAX;
    let mut current = root;

    while let Some(node) = current {
        let value = node.val as f64;
        if (value - target).abs() < (closest as f64 - target).abs() {
            closest = node.val;
        }
        current = if target < value { node.left } else { node.right };
    }

    closest
}