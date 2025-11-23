impl Solution {
    pub fn check_tree(root: Option<Box<TreeNode>>) -> bool {
        let root_node = root.unwrap();
        let left_val = root_node.left.unwrap().val;
        let right_val = root_node.right.unwrap().val;
        root_node.val == left_val + right_val
    }
}