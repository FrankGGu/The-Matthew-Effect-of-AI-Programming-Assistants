class Solution {
    public int goodNodes(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return dfs(root, Integer.MIN_VALUE);
    }

    private int dfs(TreeNode node, int maxValSoFar) {
        if (node == null) {
            return 0;
        }

        int currentGoodNodes = 0;
        if (node.val >= maxValSoFar) {
            currentGoodNodes = 1;
        }

        int newMaxVal = Math.max(maxValSoFar, node.val);

        currentGoodNodes += dfs(node.left, newMaxVal);
        currentGoodNodes += dfs(node.right, newMaxVal);

        return currentGoodNodes;
    }
}