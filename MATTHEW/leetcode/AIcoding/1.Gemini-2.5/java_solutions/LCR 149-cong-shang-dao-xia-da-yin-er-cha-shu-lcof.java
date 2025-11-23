class Solution {
    int maxLen;

    public int decorateRecord(TreeNode root) {
        if (root == null) {
            return 0;
        }
        maxLen = 0;
        dfs(root, -1, 0);
        return maxLen;
    }

    private void dfs(TreeNode node, int parentVal, int currentPathLength) {
        if (node == null) {
            return;
        }

        int lenToNode;
        if (parentVal == -1) {
            lenToNode = 1;
        } else if (node.val != parentVal) {
            lenToNode = currentPathLength + 1;
        } else {
            lenToNode = 0;
        }

        if (node.left == null && node.right == null) {
            maxLen = Math.max(maxLen, lenToNode);
            return;
        }

        if (lenToNode > 0) {
            dfs(node.left, node.val, lenToNode);
            dfs(node.right, node.val, lenToNode);
        }
    }
}