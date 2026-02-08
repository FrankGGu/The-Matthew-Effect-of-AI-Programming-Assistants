public class Solution {

class Solution {
    public TreeNode addOneRow(TreeNode root, int val, int depth) {
        if (depth == 1) {
            TreeNode newRoot = new TreeNode(val);
            newRoot.left = root;
            return newRoot;
        }
        dfs(root, val, depth, 1);
        return root;
    }

    private void dfs(TreeNode node, int val, int depth, int currentDepth) {
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
        } else {
            dfs(node.left, val, depth, currentDepth + 1);
            dfs(node.right, val, depth, currentDepth + 1);
        }
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}