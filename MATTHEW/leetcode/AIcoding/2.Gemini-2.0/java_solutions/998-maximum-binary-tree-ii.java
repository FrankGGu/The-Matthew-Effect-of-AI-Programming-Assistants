class Solution {
    public TreeNode insertIntoMaxTree(TreeNode root, int val) {
        TreeNode node = new TreeNode(val);
        if (root == null) {
            return node;
        }

        if (val > root.val) {
            node.left = root;
            return node;
        }

        TreeNode current = root;
        while (current.right != null && current.right.val > val) {
            current = current.right;
        }

        node.left = current.right;
        current.right = node;

        return root;
    }
}