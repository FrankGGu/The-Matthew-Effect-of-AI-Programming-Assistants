class Solution {
    public int sumRootToLeaf(TreeNode root) {
        return dfs(root, 0);
    }

    private int dfs(TreeNode node, int currentNumber) {
        if (node == null) {
            return 0;
        }

        currentNumber = (currentNumber << 1) | node.val;

        if (node.left == null && node.right == null) {
            return currentNumber;
        }

        return dfs(node.left, currentNumber) + dfs(node.right, currentNumber);
    }
}