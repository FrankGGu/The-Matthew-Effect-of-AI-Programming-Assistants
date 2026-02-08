class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public TreeNode addOneRow(TreeNode root, int v, int d) {
        if (d == 1) {
            TreeNode newRoot = new TreeNode(v);
            newRoot.left = root;
            return newRoot;
        }
        addRow(root, v, d - 1);
        return root;
    }

    private void addRow(TreeNode node, int v, int d) {
        if (node == null) return;
        if (d == 1) {
            TreeNode newLeft = new TreeNode(v);
            newLeft.left = node.left;
            node.left = newLeft;
            TreeNode newRight = new TreeNode(v);
            newRight.right = node.right;
            node.right = newRight;
        } else {
            addRow(node.left, v, d - 1);
            addRow(node.right, v, d - 1);
        }
    }
}