class Solution {
    int max_len = 0;

    public int longestUnivaluePath(TreeNode root) {
        dfs(root);
        return max_len;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int left_path_from_child = dfs(node.left);
        int right_path_from_child = dfs(node.right);

        int current_left_path_extensible = 0;
        int current_right_path_extensible = 0;

        if (node.left != null && node.left.val == node.val) {
            current_left_path_extensible = 1 + left_path_from_child;
        }
        if (node.right != null && node.right.val == node.val) {
            current_right_path_extensible = 1 + right_path_from_child;
        }

        max_len = Math.max(max_len, current_left_path_extensible + current_right_path_extensible);

        return Math.max(current_left_path_extensible, current_right_path_extensible);
    }
}