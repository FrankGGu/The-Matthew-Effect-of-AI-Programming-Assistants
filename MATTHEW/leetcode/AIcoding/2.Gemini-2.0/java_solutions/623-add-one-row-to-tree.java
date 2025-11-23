class Solution {
    public TreeNode addOneRow(TreeNode root, int val, int depth) {
        if (depth == 1) {
            TreeNode newRoot = new TreeNode(val);
            newRoot.left = root;
            return newRoot;
        }

        addOneRowHelper(root, val, depth, 1);
        return root;
    }

    private void addOneRowHelper(TreeNode node, int val, int depth, int currentDepth) {
        if (node == null) {
            return;
        }

        if (currentDepth == depth - 1) {
            TreeNode left = node.left;
            TreeNode right = node.right;

            node.left = new TreeNode(val);
            node.right = new TreeNode(val);

            node.left.left = left;
            node.right.right = right;
            return;
        }

        addOneRowHelper(node.left, val, depth, currentDepth + 1);
        addOneRowHelper(node.right, val, depth, currentDepth + 1);
    }
}