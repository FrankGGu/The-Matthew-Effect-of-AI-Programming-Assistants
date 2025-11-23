class Solution {
    public int deepestLeavesSum(TreeNode root) {
        int deepestLevel = findDeepestLevel(root);
        return sumDeepestLeaves(root, 1, deepestLevel);
    }

    private int findDeepestLevel(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return 1 + Math.max(findDeepestLevel(root.left), findDeepestLevel(root.right));
    }

    private int sumDeepestLeaves(TreeNode root, int level, int deepestLevel) {
        if (root == null) {
            return 0;
        }
        if (level == deepestLevel) {
            return root.val;
        }
        return sumDeepestLeaves(root.left, level + 1, deepestLevel) + sumDeepestLeaves(root.right, level + 1, deepestLevel);
    }
}