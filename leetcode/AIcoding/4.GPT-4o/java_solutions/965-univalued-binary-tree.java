class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    public boolean isUnivalTree(TreeNode root) {
        return isUnival(root, root.val);
    }

    private boolean isUnival(TreeNode node, int value) {
        if (node == null) {
            return true;
        }
        if (node.val != value) {
            return false;
        }
        return isUnival(node.left, value) && isUnival(node.right, value);
    }
}