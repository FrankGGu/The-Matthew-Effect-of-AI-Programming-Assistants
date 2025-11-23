import java.util.*;

class TreeNode {
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

class Solution {
    public TreeNode decorateTree(TreeNode root) {
        List<Integer> leaves = new ArrayList<>();
        getLeaves(root, leaves);
        return decorate(root, leaves);
    }

    private void getLeaves(TreeNode root, List<Integer> leaves) {
        if (root == null) return;
        if (root.left == null && root.right == null) {
            leaves.add(root.val);
            return;
        }
        getLeaves(root.left, leaves);
        getLeaves(root.right, leaves);
    }

    private TreeNode decorate(TreeNode root, List<Integer> leaves) {
        if (root == null) return null;

        if (root.left == null && root.right == null) return root;

        TreeNode newRoot = new TreeNode(leaves.remove(0));
        newRoot.left = root;
        newRoot.right = decorate(root.right, leaves);
        root.right = decorate(root.left, leaves);
        root.left = null;

        return newRoot;
    }
}