class Solution {
    public int maxNodeValue(TreeNode root) {
        if (root == null) return 0;
        return root.val + Math.max(maxNodeValue(root.left), maxNodeValue(root.right));
    }
}