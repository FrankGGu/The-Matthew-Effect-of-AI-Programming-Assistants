class Solution {
    int maxDepth = -1;
    int deepestSum = 0;

    public int deepestLeavesSum(TreeNode root) {
        dfs(root, 0);
        return deepestSum;
    }

    private void dfs(TreeNode node, int currentDepth) {
        if (node == null) {
            return;
        }

        if (currentDepth > maxDepth) {
            maxDepth = currentDepth;
            deepestSum = node.val;
        } else if (currentDepth == maxDepth) {
            deepestSum += node.val;
        }

        dfs(node.left, currentDepth + 1);
        dfs(node.right, currentDepth + 1);
    }
}